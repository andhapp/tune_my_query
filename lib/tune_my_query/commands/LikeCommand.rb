class LikeCommand
  class << self
    def execute(condition)
      if condition.is_a?(Array)
        condition.each { |c| execute(c) }
      elsif condition.is_a?(String)
        condition.gsub!(/ ilike /i, " like ") if condition.is_a?(String)          
      end      
    end    
  end
end