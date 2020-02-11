# 0. Update System
sudo apt -y update
sudo apt -y full-upgrade
sudo apt -y autoremove



sudo apt-get install -y build-essential checkinstall cmake unzip pkg-config libjpeg-dev libtiff-dev libavcodec-dev libswscale-dev libv4l-dev libgtk-3-dev libatlas-base-dev libgdbm-dev libc6-dev libbz2-dev libffi-dev gfortran 
sudo apt-get install -y libgoogle-glog-dev libeigen3-dev  libreadline-gplv2-dev libncursesw5-dev libssl-dev libsqlite3-dev tk-dev zlib1g-dev python-pip python3 python3-dev python3-pip libsuitesparse-dev

sudo pip3 install exifread==2.1.2 gpxpy==1.1.2 networkx==1.11 numpy scipy pyproj==1.9.5.1 pytest==3.0.7 python-dateutil==2.6.0 PyYAML==3.12 xmltodict==0.10.2 cloudpickle==0.4.0 loky==1.2.1 Pillow joblib repoze.lru setuptools opencv-python

alias python=python3


# 1. Install OpenCV 4
cd ~
wget -O opencv.zip https://github.com/opencv/opencv/archive/4.0.0.zip
wget -O opencv_contrib.zip https://github.com/opencv/opencv_contrib/archive/4.0.0.zip

unzip opencv.zip
unzip opencv_contrib.zip

rm opencv.zip
rm opencv_contrib.zip

mv opencv-4.0.0 opencv
mv opencv_contrib-4.0.0 opencv_contrib

cd opencv
mkdir build && cd build/
cmake -D CMAKE_BUILD_TYPE=Release -D OPENCV_EXTRA_MODULES_PATH=~/opencv_contrib/modules -D CMAKE_INSTALL_PREFIX=/usr/local ..
make -j4
sudo make install


# 2. Install OpenGV
cd ~
git clone https://github.com/laurentkneip/opengv
cd opengv/
git submodule update --init --recursive
mkdir build && cd build/
cmake ../ -DBUILD_PYTHON=ON -DPYBIND11_PYTHON_VERSION=3.6 -DPYTHON_INSTALL_DIR=/usr/local/lib/python3.6/dist-packages/
make -j4
sudo make install

# 3. Install Ceres-Solver
cd ~
wget http://ceres-solver.org/ceres-solver-1.14.0.tar.gz
tar zxf ceres-solver-1.14.0.tar.gz
mkdir ceres-bin && cd ceres-bin/
cmake ../ceres-solver-1.14.0 -DCMAKE_C_FLAGS=-fPIC -DCMAKE_CXX_FLAGS=-fPIC
make -j4
make test
sudo make install


# 4. Install OpenSfM
cd ~
git clone --recursive https://github.com/mapillary/OpenSfM
cd OpenSfM
git submodule update --init --recursive
mkdir build
pip3 install -r requirements.txt && python setup.py build


# 5. Test OpenSfM Installation
./bin/opensfm_run_all data/berlin/
echo done
