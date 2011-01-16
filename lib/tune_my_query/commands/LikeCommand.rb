# LIKE COMMAND                                                                    #
# Command for matching and substituting occurences of LIKE in the parameter given #
# Has one singleton method called 'execute' which performs the main function      #
#                                                                                 #
class LikeCommand
  class << self
    def execute(condition)
      if condition.is_a?(Array)
        condition.each { |c| execute(c) } # Calling itself on each element if the supplied parameter is an Array
      elsif condition.is_a?(String)
        condition.gsub!(/ ilike /i, " like ") if condition.is_a?(String)
      end
    end
  end
end
