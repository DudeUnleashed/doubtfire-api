# Doubtfire will deprecate ActiveModelSerializer in the future.
# Instead, write a serialize method on the

class GroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :tutorial_id, :group_set_id, :student_count, :capacity_adjustment, :locked

  def student_count
    return object.student_count if object.has_attribute?(:student_count)
    return object[:student_count] if object.has_attribute?(:has_key?) && object.has_key?(:student_count)
    return 0
  end
end

class DeepGroupSerializer < ActiveModel::Serializer
  attributes :id, :name, :tutorial_id, :group_set_id, :projects, :capacity_adjustment, :student_count, :locked

  def projects
    object.projects.map { |p| p.id }
  end

  def student_count
    object.projects.count
  end

end
