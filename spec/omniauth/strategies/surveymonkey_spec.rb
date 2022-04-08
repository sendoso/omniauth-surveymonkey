require 'omniauth-surveymonkey'

describe OmniAuth::Strategies::Surveymonkey do
  context 'with url context' do
    subject do
      OmniAuth::Strategies::Surveymonkey.new(nil, {})
    end

    describe '#client' do
      it 'has correct surveymonkey api site' do
        subject.options.client_options.site.should == ('https://api.surveymonkey.net')
      end

      it 'has correct access token path' do
        subject.options.client_options.token_url.should == ('/oauth/token')
      end

      it 'has correct authorize url' do
        subject.options.client_options.authorize_url.should == ('/oauth/authorize')
      end
    end

    describe '#callback_path' do
      it 'should have the correct callback path' do
        subject.callback_path.should == ('/auth/surveymonkey/callback')
      end
    end
  end

  context 'with auth info' do
    subject do
      args = ['client_id', 'secret']

      OmniAuth::Strategies::Surveymonkey.new(nil, *args).tap do |strategy|
        strategy.stub(:request) { @request }
      end
    end

    describe '#uid' do
      before do
        subject.stub(:raw_info) do
          { 'id' => '123' }
        end
      end

      it 'returns the id from raw_info' do
        subject.uid.should eq('123')
      end
    end

    describe '#info' do
      before do
        subject.stub(:raw_info) do
          {
            'username' => 'ahmad',
            'first_name' => 'Ahmad',
            'last_name' => 'Ali',
            'email' => 'ahmad.ali@sendoso.com'
          }
        end
      end

      context 'when optional data is present in raw info' do
        it 'has all the expecting attributes' do
          subject.info.keys.should eq(['username', 'name', 'email'])
          subject.info['username'].should eq('ahmad')
          subject.info['name'].should eq('Ahmad Ali')
          subject.info['email'].should eq('ahmad.ali@sendoso.com')
        end
      end
    end
  end
end