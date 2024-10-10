class Bashate < Formula
  include Language::Python::Virtualenv

  desc "Code style enforcement for bash programs"
  homepage "https://github.com/openstack/bashate"
  url "https://files.pythonhosted.org/packages/4d/0c/35b92b742cc9da7788db16cfafda2f38505e19045ae1ee204ec238ece93f/bashate-2.1.1.tar.gz"
  sha256 "4bab6e977f8305a720535f8f93f1fb42c521fcbc4a6c2b3d3d7671f42f221f4c"
  license "Apache-2.0"
  revision 1

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "07f7dadb876c05a283764cece93eb562df72377df4a26d7dfebb947fffdc7585"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "cef7fcf0ee622eac38ae68dab65871fefe0b97e31f5c814f8d158627c61ff497"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "81782b93d1a81a96621647b41c65a720c0cf26d995bdce0d5fea85572adc365f"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "77db33d9a146b930bee954a0ea2d42eff50fe0ffde1fa7c82d1c199d600750ab"
    sha256 cellar: :any_skip_relocation, sonoma:         "d6af41973ffa58f39fbdb94f146cde5ac30bb198688264ca9a58d711c3bc2b23"
    sha256 cellar: :any_skip_relocation, ventura:        "6db4c350ffbccdf07cd35aa8bf82045ada101b44c77cac84666af30e560da92c"
    sha256 cellar: :any_skip_relocation, monterey:       "a100cd15d96ec8c367311de80f9561d2db4334a261d30ac8623f50a00311ba2e"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "26d84e8ccddbbcefd2d6de2b2d45c44613f795e2f94c400730666dfec9fab539"
  end

  depends_on "python@3.13"

  resource "pbr" do
    url "https://files.pythonhosted.org/packages/b2/35/80cf8f6a4f34017a7fe28242dc45161a1baa55c41563c354d8147e8358b2/pbr-6.1.0.tar.gz"
    sha256 "788183e382e3d1d7707db08978239965e8b9e4e5ed42669bf4758186734d5f24"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    (testpath/"test.sh").write <<~EOS
      #!/bin/bash
        echo "Testing Bashate"
    EOS

    assert_match "E003 Indent not multiple of 4", shell_output("#{bin}/bashate #{testpath}/test.sh", 1)
    assert_empty shell_output("#{bin}/bashate -i E003 #{testpath}/test.sh")

    assert_match version.to_s, shell_output("#{bin}/bashate --version")
  end
end
