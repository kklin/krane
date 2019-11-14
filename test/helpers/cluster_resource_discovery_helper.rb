# frozen_string_literal: true
module ClusterResourceDiscoveryHelper
  def mocked_cluster_resource_discovery(response, success: true)
    Krane::Kubectl.any_instance.stubs(:run)
      .with("api-resources", "--namespaced=false", attempts: 5, use_namespace: false, output: "wide")
      .returns([response, "", stub(success?: success)])
    Krane::ClusterResourceDiscovery.new(task_config: task_config, namespace_tags: [])
  end

  def api_versions_full_response
    File.read(File.join(fixture_path('for_unit_tests'), "api_versions.txt"))
  end

  def api_resources_full_response
    File.read(File.join(fixture_path('for_unit_tests'), "api_resources.txt"))
  end
end
