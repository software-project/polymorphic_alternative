module PolymorphicAlternative
  module Relations

    def polymorphic_belongs_to relation_name, relations = []
      @polymorphic_relations ||= {}
      @polymorphic_relations = @polymorphic_relations.merge(relation_name.to_sym => relations)
      relations.each do |relation|
        belongs_to relation.to_sym
      end

      class_eval <<-METHODS, __FILE__, __LINE__ + 1
        def #{relation_name}
          @polymorphic_relations[#{relation_name}].each{|relation|
            return self.send relation unless self.send(relation + "_id").blank?
          }
        end
      METHODS
    end

  end
end
