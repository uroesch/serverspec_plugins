module Serverspec # :nodoc:
  module Type # :nodoc:
    class Owncloud < Base # :nodoc:
      def initialize(args)
        super
        @user      = args[:user]
        @directory = args[:directory]
        @base_cmd  = %(su - #{@user} -c '#{@directory}/occ )
      end

      def has_enabled_app?(app, version)
        params = %(app:list | egrep "#{app}: )
        params << %(.*#{version}) if version
        params << %("')
        ret = run_occ_command_with(params)
        (ret.exit_status == 0 ? true : false)
      end

      def has_disabled_app?(app)
        params = %(app:list | egrep "#{app}$")
        params << "'"
        ret = run_occ_command_with(params)
        (ret.exit_status == 0 ? true : false)
      end

      def has_configuration?(key, val)
        params  = %(config:system:get #{key}')
        ret     = run_occ_command_with(params)
        ret_val = ret.stdout.strip
        val = (val.nil? ? '' : val)
        ret_val = (val.class == Fixnum ? ret_val.to_i : ret_val)
        if ret_val.match(val)
          return true
        else
          return false
        end
      end

      def to_s
        %(ownCloud running under user "#{@user}" with installation "#{@directory}")
      end

      private

      def run_occ_command_with(params)
        @runner.run_command(@base_cmd + params)
      end
    end

    def owncloud(args)
      Owncloud.new(args)
    end
  end
end

