module Serverspec # :nodoc:
  module Type # :nodoc:
    class Dovecot < Base # :nodoc:
      def has_configuration?(key, val)
        ret     = @runner.run_command("doveconf -h #{key}")
        ret_val = ret.stdout.strip
        val = (val.nil? ? '' : val)
        ret_val = (val.class == Fixnum ? ret_val.to_i : ret_val)
        if val == ret_val
          return true
        else
          return false
        end
      end

      def to_s
        'Dovecot'
      end
    end

    def dovecot
      Dovecot.new
    end
  end
end
