require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'factory_bot_rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

# --- 追加：Fiber/Threadの競合を強制的に防ぐ設定 ---
# Rails 7.1以降のコネクション共有問題を解決します
module ActiveRecord
  module ConnectionAdapters
    class ConnectionPool
      def connection
        @thread_cached_conns[Thread.current.object_id] ||= checkout
      end
    end
  end
end
# ----------------------------------------------

RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods

  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # トランザクションによる掃除を有効にする
  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  # テスト実行前に接続をリセット
  config.before(:suite) do
    ActiveRecord::Base.connection_handler.clear_active_connections!
  end

  # 各テスト終了後に接続を確実にクリア
  config.after(:each) do
    ActiveRecord::Base.connection_handler.clear_active_connections!
  end
end
