#
# Copyright Peter Donald
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

default['chef_client']['handler']['graphite']['host'] = nil
default['chef_client']['handler']['graphite']['port'] = nil
default['chef_client']['handler']['graphite']['prefix'] = "chef.#{node.chef_environment}.node.#{node['hostname']}"
