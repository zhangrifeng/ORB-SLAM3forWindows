/**
* This file is part of ORB-SLAM3
*
* Copyright (C) 2017-2020 Carlos Campos, Richard Elvira, Juan J. Gómez Rodríguez, José M.M. Montiel and Juan D. Tardós, University of Zaragoza.
* Copyright (C) 2014-2016 Raúl Mur-Artal, José M.M. Montiel and Juan D. Tardós, University of Zaragoza.
*
* ORB-SLAM3 is free software: you can redistribute it and/or modify it under the terms of the GNU General Public
* License as published by the Free Software Foundation, either version 3 of the License, or
* (at your option) any later version.
*
* ORB-SLAM3 is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even
* the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
* GNU General Public License for more details.
*
* You should have received a copy of the GNU General Public License along with ORB-SLAM3.
* If not, see <http://www.gnu.org/licenses/>.
*/


#include<iostream>
#include<algorithm>
#include<fstream>
#include<chrono>
#include <ctime>
#include <sstream>

#include<opencv2/core/core.hpp>

#include<System.h>
#include "ImuTypes.h"
#include <windows.h>
inline void usleep(__int64 usec) {
	Sleep(usec / 1000);  // Windows 的 Sleep 以 ms 为单位
}
using namespace std;

void LoadImages(const string& strImagePath, const string& strPathTimes,
	vector<string>& vstrImages, vector<double>& vTimeStamps);

void LoadIMU(const string& strImuPath, vector<double>& vTimeStamps, vector<cv::Point3f>& vAcc, vector<cv::Point3f>& vGyro);

double ttrack_tot = 0;
int main(int argc, char* argv[])
{
	// 手动指定参数
	argc = 5;
	char* new_argv[] = {
		"mono_inertial_euroc.exe",
		"E:/cpp/ORB-SLAM3forWindows/Vocabulary/ORBvoc.txt",
		"E:/cpp/ORB-SLAM3forWindows/Examples/Monocular-Inertial/EuRoC.yaml",
		"E:/cpp/MH_01_easy/",
		"E:/cpp/ORB-SLAM3forWindows/Examples/Monocular-Inertial/EuRoC_TimeStamps/MH01.txt",
		nullptr  // argv 必须以 nullptr 结尾
	};
	argv = new_argv;

	if (argc < 5)
	{
		cerr << endl << "Usage: ./mono_inertial_euroc path_to_vocabulary path_to_settings path_to_sequence_folder_1 path_to_times_file_1 (path_to_image_folder_2 path_to_times_file_2 ... path_to_image_folder_N path_to_times_file_N) " << endl;
		return 1;
	}

	const int num_seq = (argc - 3) / 2;//每对图像文件夹路径和时间戳文件路径对应一个序列，所以需要除以2。
	cout << "num_seq = " << num_seq << endl;
	/*bFileName 判断是否传入了额外的文件名参数。
	如果(argc - 3) % 2 == 1 为真，表示有一个额外的文件名参数。
	如果存在额外的文件名参数，则将其存储在 file_name 中。*/
	bool bFileName = (((argc - 3) % 2) == 1);
	string file_name;
	if (bFileName)
	{
		file_name = string(argv[argc - 1]);
		cout << "file name: " << file_name << endl;
	}

	// Load all sequences:
	int seq;
	vector< vector<string> > vstrImageFilenames;//每个序列的图像文件名列表。
	vector< vector<double> > vTimestampsCam;//每个序列的图像时间戳。
	vector< vector<cv::Point3f> > vAcc, vGyro;//每个序列的加速度计数据、陀螺仪数据。
	vector< vector<double> > vTimestampsImu; //每个序列的IMU时间戳。
	vector<int> nImages;//每个序列中的图像数量。
	vector<int> nImu;//每个序列中的IMU数据数量。
	vector<int> first_imu(num_seq, 0);//每个序列中第一个可用的IMU数据的索引。

	vstrImageFilenames.resize(num_seq);
	vTimestampsCam.resize(num_seq);
	vAcc.resize(num_seq);
	vGyro.resize(num_seq);
	vTimestampsImu.resize(num_seq);
	nImages.resize(num_seq);
	nImu.resize(num_seq);

	int tot_images = 0;
	for (seq = 0; seq < num_seq; seq++)
	{
		cout << "Loading images for sequence " << seq << "...";

		string pathSeq(argv[(2 * seq) + 3]);
		string pathTimeStamps(argv[(2 * seq) + 4]);

		string pathCam0 = pathSeq + "/mav0/cam0/data";
		string pathImu = pathSeq + "/mav0/imu0/data.csv";
		cout << "pathCam0:" << pathCam0 << endl;
		cout << "pathImu:" << pathImu << endl;


		LoadImages(pathCam0, pathTimeStamps, vstrImageFilenames[seq], vTimestampsCam[seq]);
		cout << "LOADED!" << endl;

		cout << "Loading IMU for sequence " << seq << "...";
		LoadIMU(pathImu, vTimestampsImu[seq], vAcc[seq], vGyro[seq]);
		cout << "LOADED!" << endl;

		nImages[seq] = vstrImageFilenames[seq].size();
		tot_images += nImages[seq];
		nImu[seq] = vTimestampsImu[seq].size();

		if ((nImages[seq] <= 0) || (nImu[seq] <= 0))
		{
			cerr << "ERROR: Failed to load images or IMU for sequence" << seq << endl;
			return 1;
		}

		// Find first imu to be considered, supposing imu measurements start first

		while (vTimestampsImu[seq][first_imu[seq]] <= vTimestampsCam[seq][0])
			first_imu[seq]++;
		first_imu[seq]--; // first imu measurement to be considered

	}

	// Vector for tracking time statistics
	vector<float> vTimesTrack;
	vTimesTrack.resize(tot_images);

	cout.precision(17);

	/*cout << "Start processing sequence ..." << endl;
	cout << "Images in the sequence: " << nImages << endl;
	cout << "IMU data in the sequence: " << nImu << endl << endl;*/

	// Create SLAM system. It initializes all system threads and gets ready to process frames.
	ORB_SLAM3::System SLAM(argv[1], argv[2], ORB_SLAM3::System::IMU_MONOCULAR, true);
	/*argv[1] 是ORB词汇文件的路径。
	 argv[2] 是配置文件的路径。
	 ORB_SLAM3::System::IMU_MONOCULAR 表示使用单目相机和IMU数据进行SLAM。
	 true 表示启动图像和IMU的同步处理。*/

	int proccIm = 0;
	for (seq = 0; seq < num_seq; seq++)
	{

		// Main loop
		cv::Mat im;
		vector<ORB_SLAM3::IMU::Point> vImuMeas;
		proccIm = 0;
		/*im: 用于存储当前加载的图像。
		vImuMeas : 用于存储从上一个图像时间戳到当前图像时间戳之间的IMU测量数据。
		ni : 当前处理的图像帧索引，nImages[seq] 是当前序列中的图像数量。*/
		for (int ni = 0; ni < nImages[seq]; ni++, proccIm++)
		{
			// Read image from file
			im = cv::imread(vstrImageFilenames[seq][ni], cv::IMREAD_UNCHANGED);

			double tframe = vTimestampsCam[seq][ni];//存储当前图像的时间戳，用于同步IMU数据。

			if (im.empty())
			{
				cerr << endl << "Failed to load image at: "
					<< vstrImageFilenames[seq][ni] << endl;
				return 1;
			}

			// Load imu measurements from previous frame
			vImuMeas.clear();
			/*对于每一帧图像，系统会清空 vImuMeas，并加载从上一帧到当前帧之间的IMU数据。
			vAcc[seq] 和 vGyro[seq] 分别表示加速度计和陀螺仪的数据。
			first_imu[seq] 是当前需要处理的IMU数据索引。*/

			if (ni > 0)
			{
				// cout << "t_cam " << tframe << endl;

				while (vTimestampsImu[seq][first_imu[seq]] <= vTimestampsCam[seq][ni])
				{
					vImuMeas.push_back(ORB_SLAM3::IMU::Point(vAcc[seq][first_imu[seq]].x, vAcc[seq][first_imu[seq]].y, vAcc[seq][first_imu[seq]].z,
						vGyro[seq][first_imu[seq]].x, vGyro[seq][first_imu[seq]].y, vGyro[seq][first_imu[seq]].z,
						vTimestampsImu[seq][first_imu[seq]]));
					first_imu[seq]++;
				}
			}

			/*cout << "first imu: " << first_imu << endl;
			cout << "first imu time: " << fixed << vTimestampsImu[first_imu] << endl;
			cout << "size vImu: " << vImuMeas.size() << endl;*/

#ifdef COMPILEDWITHC11
			std::chrono::steady_clock::time_point t1 = std::chrono::steady_clock::now();
#else
			//std::chrono::monotonic_clock::time_point t1 = std::chrono::monotonic_clock::now();
			std::chrono::steady_clock::time_point t1 = std::chrono::steady_clock::now();
#endif

			// Pass the image to the SLAM system
			// cout << "tframe = " << tframe << endl;
			SLAM.TrackMonocular(im, tframe, vImuMeas); // TODO change to monocular_inertial
			//将当前图像 im、时间戳 tframe 和IMU测量数据 vImuMeas 传入 ORB-SLAM3 系统进行处理，进行 单目视觉-惯性SLAM。

#ifdef COMPILEDWITHC11
			std::chrono::steady_clock::time_point t2 = std::chrono::steady_clock::now();
#else
		//std::chrono::monotonic_clock::time_point t2 = std::chrono::monotonic_clock::now();
			std::chrono::steady_clock::time_point t2 = std::chrono::steady_clock::now();
#endif

			double ttrack = std::chrono::duration_cast<std::chrono::duration<double>>(t2 - t1).count();
			ttrack_tot += ttrack;
			// std::cout << "ttrack: " << ttrack << std::endl;

			vTimesTrack[ni] = ttrack;

			// Wait to load the next frame
			/*根据相机的时间戳，计算下一帧图像的时间间隔 T。
				如果图像处理时间 ttrack 小于帧间隔 T，则程序会休眠一段时间，以模拟真实相机的拍摄速率。*/
			double T = 0;
			if (ni < nImages[seq] - 1)
				T = vTimestampsCam[seq][ni + 1] - tframe;
			else if (ni > 0)
				T = tframe - vTimestampsCam[seq][ni - 1];

			if (ttrack < T)
				usleep((T - ttrack) * 1e6); // 1e6
		}
		if (seq < num_seq - 1)
		{
			cout << "Changing the dataset" << endl;

			SLAM.ChangeDataset();
		}
	}

	// Stop all threads
	SLAM.Shutdown();

	// Save camera trajectory
	if (bFileName)
	{
		const string kf_file = "kf_" + string(argv[argc - 1]) + ".txt";
		const string f_file = "f_" + string(argv[argc - 1]) + ".txt";
		SLAM.SaveTrajectoryEuRoC(f_file);
		SLAM.SaveKeyFrameTrajectoryEuRoC(kf_file);
	}
	else
	{
		SLAM.SaveTrajectoryEuRoC("CameraTrajectory.txt");
		SLAM.SaveKeyFrameTrajectoryEuRoC("KeyFrameTrajectory.txt");
	}

	return 0;
}

void LoadImages(const string& strImagePath, const string& strPathTimes,
	vector<string>& vstrImages, vector<double>& vTimeStamps)
{
	cout << "strImagePath:" << strImagePath << "\n" << endl;
	cout << "strPathTimes:" << strPathTimes << "\n" << endl;
	ifstream fTimes;
	fTimes.open(strPathTimes.c_str());
	vTimeStamps.reserve(5000);
	vstrImages.reserve(5000);
	while (!fTimes.eof())
	{
		string s;
		getline(fTimes, s);
		//cout << s << endl;
		if (!s.empty())
		{
			stringstream ss;
			ss << s;
			vstrImages.push_back(strImagePath + "/" + ss.str() + ".png");
			double t;
			ss >> t;
			vTimeStamps.push_back(t / 1e9);

		}
	}
}

void LoadIMU(const string& strImuPath, vector<double>& vTimeStamps, vector<cv::Point3f>& vAcc, vector<cv::Point3f>& vGyro)
{
	ifstream fImu;
	fImu.open(strImuPath.c_str());
	vTimeStamps.reserve(5000);
	vAcc.reserve(5000);
	vGyro.reserve(5000);

	while (!fImu.eof())
	{
		string s;
		getline(fImu, s);
		if (s[0] == '#')
			continue;

		if (!s.empty())
		{
			string item;
			size_t pos = 0;
			double data[7];
			int count = 0;
			while ((pos = s.find(',')) != string::npos) {
				item = s.substr(0, pos);
				data[count++] = stod(item);
				s.erase(0, pos + 1);
			}
			item = s.substr(0, pos);
			data[6] = stod(item);

			vTimeStamps.push_back(data[0] / 1e9);
			vAcc.push_back(cv::Point3f(data[4], data[5], data[6]));
			vGyro.push_back(cv::Point3f(data[1], data[2], data[3]));
		}
	}
}