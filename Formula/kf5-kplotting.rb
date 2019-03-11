class Kf5Kplotting < Formula
  desc "Lightweight plotting framework"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.56/kplotting-5.56.0.tar.xz"
  sha256 "39e44138af405f8e07eb91d660447a770394bf8fae166634a386e873761c33c3"

  revision 1
  head "git://anongit.kde.org/kplotting.git"
  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "ninja" => :build

  depends_on "qt"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end
end
