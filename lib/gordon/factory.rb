module Gordon
  class Factory
    def self.create_instance(namespace, object_type)
      fragments = object_type.split('_')

      type = fragments.map do |fragment|
        fragment[0].upcase + fragment[1..-1]
      end.join('')

      ns = "Gordon::#{namespace}::#{type}"

      klass = ns.split('::').inject(Object) do |obj, ns|
        obj.const_get(ns)
      end

      klass.new
    end
  end
end
