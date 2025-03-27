# /bin/bash
mkdir build
cd build
cmake -DCMAKE_PREFIX_PATH="/opt/rocm" -DMIOPEN_BACKEND=HIPNOGPU -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..
#AMD clang has issues with support for codeql, in teh build tracer log most files are excluded due to bad mode...
# I have a feeling that --offload-arch=gfx90a  flag might be the one to blame but im not 100% sure.
#CXX=/opt/rocm/llvm/bin/clang++ cmake -DCMAKE_PREFIX_PATH="/opt/rocm" -DMIOPEN_BACKEND=HIPNOGPU -DCMAKE_BUILD_TYPE=Release -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..
num_pro="$(nproc)"
# the build obviously fails if we dont use amd clang.  This was a test. 
# if we dont use amd clang we get 213 files scanned out of 1377 instead of only 7...
# however, it only got results from test folders, I checked in the results form running this in case I come back to this one day.
make -j $num_pro -i
