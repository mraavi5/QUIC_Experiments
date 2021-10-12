sudo apt-get update 
sudo apt-get upgrade

sudo apt install zlib1g
sudo apt install zlib1g-dev

sudo apt install libevent-dev

sudo apt-get install python3-sphinx

sudo apt install -y astyle git cmake gcc ninja-build libssl-dev python3-pytest python3-pytest-xdist unzip xsltproc doxygen graphviz golang-go

mkdir oqs
cd oqs
git clone https://github.com/prchander/lsquic.git
git clone https://github.com/prchander/boringssl.git
git clone https://github.com/open-quantum-safe/liboqs.git
BORINGSSL_DIR=$PWD/boringssl

cd lsquic
git submodule init
git submodule init
cd ..

cd liboqs
rm -rf build
mkdir build && cd build
cmake -GNinja -DCMAKE_INSTALL_PREFIX=$BORINGSSL_DIR/oqs -DOQS_USE_OPENSSL=OFF ..
ninja
sudo ninja install
echo "LIBOQS SUCCESSFULLY BUILT"
cd ..

cd $BORINGSSL_DIR
sudo apt install -y cmake gcc ninja-build libunwind-dev pkg-config python3 python3-psutil
cd $BORINGSSL_DIR
rm -rf build
mkdir build && cd build
cmake -DBUILD_SHARED_LIBS=ON -GNinja ..
ninja
echo "BORINGSSL SUCCESSFULLY BUILT"
cd ../..

cd lsquic
rm -rf build
mkdir build && cd build
cmake -DBORINGSSL_DIR=$BORINGSSL_DIR -DBORINGSSL_LIB_crypto=$BORINGSSL_DIR/build/crypto/libcrypto.so -DBORINGSSL_LIB_ssl=$BORINGSSL_DIR/build/ssl/libssl.so -GNinja ..
ninja
echo "lsquic SUCCESSFULLY BUILT"