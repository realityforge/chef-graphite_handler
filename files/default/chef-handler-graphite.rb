#
# Author:: Ian Meyer <ianmmeyer@gmail.com>
# Copyright:: Copyright (c) 2012, Ian Meyer
# License:: Apache License, Version 2.0
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

require "rubygems"
require "simple-graphite"
require "chef"
require "chef/handler"

class GraphiteReporting < Chef::Handler
  attr_writer :metric_key, :graphite_host, :graphite_port

  def initialize(options = {})
    @metric_key = options[:metric_key]
    @enable_profiling = options[:enable_profiling]
    @graphite_host = options[:graphite_host]
    @graphite_port = options[:graphite_port]
  end

  def report
    g = Graphite.new
    g.host = @graphite_host
    g.port = @graphite_port

    metrics = Hash.new
    metrics[:updated_resources] = run_status.respond_to?(:updated_resources) ? run_status.updated_resources.length : 0
    metrics[:all_resources] = run_status.respond_to?(:all_resources) ? run_status.all_resources.length : 0
    metrics[:elapsed_time] = run_status.elapsed_time

    # Graph metrics from the Ohai system-packages plugin (https://github.com/finnlabs/ohai-system_packages/)
    if node.has_key? 'system_packages'
      node['system_packages'].each do |k, v|
        metrics["#{k}_packages"] = v.size if v and v.respond_to? :size
      end
    end

    if run_status.success?
      metrics[:success] = 1
      metrics[:fail] = 0
    else
      metrics[:success] = 0
      metrics[:fail] = 1
    end

    # user provided metrics
    user_metrics = run_status.run_context[:graphite_handler_metrics]
    metrics.merge!(user_metrics) if user_metrics.is_a?(Hash)

    if @enable_profiling
      cookbooks = Hash.new(0)
      recipes = Hash.new(0)
      all_resources.each do |r|
        cookbooks[r.cookbook_name] += r.elapsed_time
        recipes["#{r.cookbook_name}::#{r.recipe_name}"] += r.elapsed_time
      end
      cookbooks.each do |cookbook, run_time|
        metrics["_volatile.cookbook.#{cookbook}"] = run_time
      end
      recipes.each do |recipe, run_time|
        metrics["_volatile.recipe.#{recipe}"] = run_time
      end
    end

    begin
      g.push_to_graphite do |graphite|
        metrics.each do |metric, value|
          Chef::Log.debug("#{@metric_key}.#{metric} #{value} #{g.time_now}")
          graphite.puts "#{@metric_key}.#{metric} #{value} #{g.time_now}"
        end
      end
    rescue => e
      Chef::Log.error("Error reporting to graphite: #{e}")
    end
  end
end
