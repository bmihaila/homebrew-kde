class Kf5Krunner < Formula
  desc "Process launcher to speed up launching KDE applications"
  homepage "https://www.kde.org"
  url "https://download.kde.org/stable/frameworks/5.66/krunner-5.66.0.tar.xz"
  sha256 "b7d67d61c0b0f96128c143e3d2694dc5ced88a7de73db0f4493f084de9dc9701"

  head "git://anongit.kde.org/krunner.git"

  depends_on "cmake" => :build
  depends_on "doxygen" => :build
  depends_on "gettext" => :build
  depends_on "graphviz" => :build
  depends_on "KDE-mac/kde/kf5-extra-cmake-modules" => :build
  depends_on "KDE-mac/kde/kf5-kdoctools" => :build
  depends_on "ninja" => :build

  depends_on "KDE-mac/kde/kf5-plasma-framework"
  depends_on "KDE-mac/kde/kf5-threadweaver"

  def install
    args = std_cmake_args
    args << "-DBUILD_TESTING=OFF"
    args << "-DBUILD_QCH=ON"
    args << "-DKDE_INSTALL_QMLDIR=lib/qt5/qml"
    args << "-DKDE_INSTALL_PLUGINDIR=lib/qt5/plugins"
    args << "-DKDE_INSTALL_QTPLUGINDIR=lib/qt5/plugins"

    mkdir "build" do
      system "cmake", "-G", "Ninja", "..", *args
      system "ninja"
      system "ninja", "install"
      prefix.install "install_manifest.txt"
    end
  end

  test do
    (testpath/"CMakeLists.txt").write("find_package(KF5Runner REQUIRED)")
    system "cmake", ".", "-Wno-dev"
  end
end
