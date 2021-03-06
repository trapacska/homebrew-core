class Rakudo < Formula
  desc "Perl 6 compiler targeting MoarVM"
  homepage "https://rakudo.org"
  url "https://github.com/rakudo/rakudo/releases/download/2020.05/rakudo-2020.05.tar.gz"
  sha256 "86d1986c9a5ad1c7fe0f8875f16830cd3c4e84a3a3e05ee7e01e5234432aa121"

  bottle do
    sha256 "ba75c8999d5da4010081049ed80b12167af3360146074c49b5e5c18e3abf05e3" => :catalina
    sha256 "8847bdbda1badc11c8e8f25e828870b2c78368ba831fb3d0c747405bb14ed171" => :mojave
    sha256 "1eee417b6987fa9d03bc38e4ed913df14ec97ccdb801da28098de9cfce93c834" => :high_sierra
  end

  depends_on "nqp"

  conflicts_with "rakudo-star"

  def install
    system "perl", "Configure.pl",
                   "--backends=moar",
                   "--prefix=#{prefix}",
                   "--with-nqp=#{Formula["nqp"].bin}/nqp"
    system "make"
    system "make", "install"
    bin.install "tools/install-dist.p6" => "perl6-install-dist"
  end

  test do
    out = shell_output("#{bin}/perl6 -e 'loop (my $i = 0; $i < 10; $i++) { print $i }'")
    assert_equal "0123456789", out
  end
end
