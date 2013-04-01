template "/test.txt" do
  mode "0777"
end

package "hello" do
  package_name node["hello"]["package"]
end
