require 'spec_helper'
provider_class = Puppet::Type.type(:package).provider(:pe_gem)

describe provider_class do
  subject { provider_class }

  before do
    @resource =  Puppet::Type::Package.new(
      {
        :provider => 'pe_gem',
        :name     => 'deep_merge',
        :ensure   => 'present'
      }
    )
  end
  let (:provider) { described_class.new(@resource) }
  describe 'Puppet Enterprise' do
    let(:facts) do
      {:puppetversion => '3.7.3 (Puppet Enterprise 3.7.1)'}
    end
    describe 'windows' do
      it { expect(provider).to be_an_instance_of Puppet::Type::Package::ProviderPe_gem}
      it do
        allow(Gem).to receive(:bindir).and_return('C:\Program Files\Puppet Labs\Puppet Enterprise\sys\ruby\bin')
        expects(:gemcmd).with(['install', 'deep_merge'])
      end
    end

    describe 'Linux' do
      it { expect(provider).to be_an_instance_of Puppet::Type::Package::ProviderPe_gem}

      it do
        allow(Gem).to receive(:bindir).and_return('/opt/puppet/bin/gem')
        expects(:gemcmd).with(['install', 'deep_merge'])
      end
    end
  end

  describe 'FOSS Puppet' do
    let(:facts) do
      {:puppetversion => '3.7.3'}
    end

    describe 'windows' do
      it { expect(provider).to be_an_instance_of Puppet::Type::Package::ProviderPe_gem}
      it do
        fact = double()
        allow(fact).to receive(:value).and_return('3.7.3')
        allow(Facter).to recieve(:fact).with(:puppetversion).and_return(fact)
        allow(Gem).to receive(:bindir).and_return('C:\Program Files\Puppet Labs\Puppet Enterprise\sys\ruby\bin')
        expects(:gemcmd).with(['install', 'deep_merge'])
      end
    end

    describe 'Linux' do
      it { expect(provider).to be_an_instance_of Puppet::Type::Package::ProviderPe_gem}

      it do
        fact = double()
        allow(fact).to receive(:value).and_return('3.7.3')
        allow(Facter).to recieve(:[]).with(:puppetversion).and_return(fact)
        allow(Gem).to receive(:bindir).and_return('/opt/puppet/bin/gem')
        expects(:gemcmd).with(['install', 'deep_merge'])
      end
    end
  end

end