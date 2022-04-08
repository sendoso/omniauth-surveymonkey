# Surveymonkey Strategy for OmniAuth

SurveyMonkey OAuth2 strategy for OmniAuth
## Get Started
```ruby
gem 'surveymonkey-omniauth'
```
## Usage

In your config/initializers/omniauth.rb:

    OmniAuth.config.logger = Rails.logger
    Rails.application.config.middleware.use OmniAuth::Builder do
      provider :surveymonkey, api_key: SURVEYMONKEY_API_KEY, client_secret: SURVEYMONKEY_API_SECRET,  client_id: SURVEYMONKEY_CLIENT_ID
    end

Note that this differs from normal Omniauth configurations!
Note that this gem is an extended work on surveymonkey-with-omniauth gem

# License

Copyright (c) 2022 Ahmad Ali

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
