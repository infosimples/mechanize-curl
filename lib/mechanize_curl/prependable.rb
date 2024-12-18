# frozen_string_literal: true
# Fake implementation of prepend(), which does not support overriding
# inherited methods nor methods that are formerly overridden by
# another invocation of prepend().
#
# Here's what <Original>.prepend(<Wrapper>) does:
#
# - Create an anonymous stub module (hereinafter <Stub>) and define
#   <Stub>#<method> that calls #<method>_without_<Wrapper> for each
#   instance method of <Wrapper>.
#
# - Rename <Original>#<method> to #<method>_without_<Wrapper> for each
#   instance method of <Wrapper>.
#
# - Include <Wrapper> and <Stub> into <Original> in that order.
#
# This way, a call of <Original>#<method> is dispatched to
# <Wrapper><method>, which may call super which is dispatched to
# <Stub>#<method>, which finally calls
# <Original>#<method>_without_<Wrapper> which is used to be called
# <Original>#<method>.
#
# Usage:
#
#     class MechanizeCurl
#       # module with methods that overrides those of X
#       module Y
#       end
#
#       unless X.respond_to?(:prepend, true)
#         require 'mechanize_curl/prependable'
#         X.extend(Prependable)
#       end
#
#       class X
#         prepend Y
#       end
#     end
module MechanizeCurl::Prependable
  def prepend(mod)
    stub = Module.new

    mod_id = (mod.name || 'Module__%d' % mod.object_id).gsub(/::/, '__')

    mod.instance_methods.each { |name|
      method_defined?(name) or next

      original = instance_method(name)
      if original.owner != self
        warn "%s cannot override an inherited method: %s(%s)#%s" % [
          __method__, self, original.owner, name
        ]
        next
      end

      name = name.to_s
      name_without = name.sub(/(?=[?!=]?\z)/) { '_without_%s' % mod_id }

      arity = original.arity
      arglist = (
        if arity >= 0
          (1..arity).map { |i| 'x%d' % i }
        else
          (1..(-arity - 1)).map { |i| 'x%d' % i } << '*a'
        end << '&b'
      ).join(', ')

      if name.end_with?('=')
        stub.module_eval %{
          def #{name}(#{arglist})
            __send__(:#{name_without}, #{arglist})
          end
        }
      else
        stub.module_eval %{
          def #{name}(#{arglist})
            #{name_without}(#{arglist})
          end
        }
      end
      module_eval {
        alias_method name_without, name
        remove_method name
      }
    }

    include(mod, stub)
  end
  private :prepend
end
