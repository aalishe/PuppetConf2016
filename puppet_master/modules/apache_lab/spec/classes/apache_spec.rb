require 'spec_helper'

describe 'apache', :type => :class do

  context 'when using a Redhat system' do

    let (:facts) do
      {
        'osfamily' => 'RedHat',
      }
    end

    it { should contain_package('apache').with({
     'ensure' => 'present',
      })
    }

    it { should contain_service('apache').with({
      'ensure' => 'running',
      })
    }

  end 

  context 'when using Debian' do
  end
end
