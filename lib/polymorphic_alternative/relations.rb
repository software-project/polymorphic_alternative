module PolymorphicAlternative
  module Relations

#   Create polymorphic relation. Takes relation name and related models.
#    Example:
#
#    polymorphic_belongs_to :
    def polymorphic_belongs_to relation_name, relations = []
      class_attribute :polymorphic_relations
      self.polymorphic_relations ||= {}
      self.polymorphic_relations = self.polymorphic_relations.merge(relation_name.to_sym => relations)
      relations.each do |relation|
        belongs_to relation.to_sym
      end

      class_eval <<-METHODS, __FILE__, __LINE__ + 1
#       Gets existing relation or returns nil if not found
        def #{relation_name}
          self.polymorphic_relations[:#{relation_name}].each{|relation|
            return self.send(relation) unless self.send(relation).blank?
          }
          nil
        end

#       Gets class name of relation. For keeping compatibility with standard Rails polymorphic relation.
        def #{relation_name}_type
          self.polymorphic_relations[:#{relation_name}].each{|relation|
            return self.send(relation).class.name.to_s unless self.send(relation).blank?
          }
          nil
        end

#       Assings relation to its real parent and sets others relations to nil
        def #{relation_name}= value
          if value
            relation_class = value.class.name.underscore
          else
            self.polymorphic_relations[:#{relation_name}].each{|relation|
              self.send(relation + "_id="), nil
            }
            return nil
          end

          if self.polymorphic_relations[:#{relation_name}].any?{|rel| rel.to_sym == relation_class.to_sym}
            self.polymorphic_relations[:#{relation_name}].each{|relation|
              self.send(relation + "_id="), nil
            }
            self.send (relation_class + "="), value
          else
            raise("Cannot assign this relation to #{relation_name}")
          end
        end
      METHODS
    end

  end
end
