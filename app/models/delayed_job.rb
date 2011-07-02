class DelayedJob < ActiveRecord::Base

  scope :ordered, order("run_at")

  def title
    YAML.load(handler).class.to_s
    #{}"#{YAML.load(handler).object.to_s}.#{YAML.load(handler).method_name.to_s}"
  end

end
