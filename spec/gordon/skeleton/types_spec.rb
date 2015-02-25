require 'spec_helper'

describe Gordon::Skeleton::Types::Base do
  subject do
    class MyExample
      include Gordon::Skeleton::Types::Base

      def get_os_package_map ; { centos: :my_example, debian: :my_example } ; end

      def get_default_path ; '/a/path' ; end
    end

    MyExample.new
  end

  describe 'getting path' do
    it 'returns default path based on class' do
      expect(subject.path).to eq('/a/path/')
    end

    it 'returns a custom path' do
      expect(subject.path('customized')).to eq('/a/path/customized')
    end
  end

  describe 'getting os package name' do
    it 'returns value for mapped operational systems' do
      %w(centos debian).each do |os|
        expected = subject.get_os_package_map[os.to_sym]
        expect(subject.get_os_package_name(os.to_sym)).to eq(expected)
      end
    end

    it 'raises error if not found' do
      expect { subject.get_os_package_name(:freebsd) }.to raise_exception(Gordon::Exceptions::OperationalSystemNotMapped)
    end
  end

  describe 'checking if requires app name' do
    it 'returns false' do
      expect(subject.requires_app_name?).to be_falsey
    end
  end
end

describe Gordon::Skeleton::Types::Nginx do
  describe 'getting os package map' do
    it 'returns a map' do
      map = { centos: :nginx, debian: :nginx }

      expect(subject.get_os_package_map).to eq(map)
    end
  end

  describe 'getting default path' do
    it 'returns a path' do
      expect(subject.get_default_path).to eq('/usr/share/nginx/html')
    end
  end

  describe 'checking if requires app name' do
    it 'returns false' do
      expect(subject.requires_app_name?).to be_falsey
    end
  end
end

describe Gordon::Skeleton::Types::Apache do
  describe 'getting os package map' do
    it 'returns a map' do
      map = { centos: :httpd, debian: :apache2 }

      expect(subject.get_os_package_map).to eq(map)
    end
  end

  describe 'getting default path' do
    it 'returns a path' do
      expect(subject.get_default_path).to eq('/var/www/html')
    end
  end

  describe 'checking if requires app name' do
    it 'returns false' do
      expect(subject.requires_app_name?).to be_falsey
    end
  end
end

describe Gordon::Skeleton::Types::Tomcat do
  describe 'getting os package map' do
    it 'returns a map' do
      map = { centos: :tomcat, debian: :tomcat7 }

      expect(subject.get_os_package_map).to eq(map)
    end
  end

  describe 'getting default path' do
    it 'returns a path' do
      expect(subject.get_default_path).to eq('/var/lib/tomcat/webapps')
    end
  end

  describe 'checking if requires app name' do
    it 'returns false' do
      expect(subject.requires_app_name?).to be_falsey
    end
  end
end

describe Gordon::Skeleton::Types::Jetty do
  describe 'getting os package map' do
    it 'returns a map' do
      map = { centos: :'jetty-server', debian: :jetty }

      expect(subject.get_os_package_map).to eq(map)
    end
  end

  describe 'getting default path' do
    it 'returns a path' do
      expect(subject.get_default_path).to eq('/var/lib/jetty/webapps')
    end
  end

  describe 'checking if requires app name' do
    it 'returns false' do
      expect(subject.requires_app_name?).to be_falsey
    end
  end
end

describe Gordon::Skeleton::Types::Systemd do
  describe 'getting os package map' do
    it 'returns a map' do
      map = { centos: :systemd, debian: :systemd }

      expect(subject.get_os_package_map).to eq(map)
    end
  end

  describe 'getting default path' do
    it 'returns a path' do
      expect(subject.get_default_path).to eq('/usr/lib/systemd/system')
    end
  end

  describe 'checking if requires app name' do
    it 'returns false' do
      expect(subject.requires_app_name?).to be_falsey
    end
  end
end

describe Gordon::Skeleton::Types::Misc do
  describe 'getting default path' do
    it 'returns a path' do
      expect(subject.get_default_path).to eq('/opt')
    end
  end

  describe 'checking if requires app name' do
    it 'returns true' do
      expect(subject.requires_app_name?).to be_truthy
    end
  end
end

