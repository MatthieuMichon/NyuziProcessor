#
# Copyright 2018 Jeff Bush
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

cmake_minimum_required(VERSION 3.4)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${CMAKE_SOURCE_DIR}/cmake/")

set(NYUZI_COMPILER_ROOT /usr/local/llvm-nyuzi/ CACHE PATH "Path to nyuzi compiler install directory.")
set(NYUZI_COMPILER_BIN ${NYUZI_COMPILER_ROOT}/bin)

add_subdirectory(tools)
add_subdirectory(software)
add_subdirectory(hardware)
add_subdirectory(tests)
