

package 'curl'
package 'git-core'

bash "installing system-wide RVM stable" do
  user "root"
  code "curl -L get.rvm.io | sudo bash -s stable; echo"
  not_if "test -e /usr/local/rvm/bin/rvm"
end

