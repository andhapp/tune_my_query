module TuneMyQuery
  
  # Hook invoked in include
  def self.included(base)
    base.class_eval do
      extend ClassMethods
      class << self
        alias_method :super_merge_conditions, :merge_conditions
        alias_method :merge_conditions, :standardise_sql
      end
    end
  end
  
  #                                                                                                   #
  # Adds tune_my_query method to ActiveRecord and its subclasses.                                     #
  #                                                                                                   #
  # USAGE:                                                                                            #    
  #      tune_my_query :like                                                                          #
  #                                                                                                   #
  # 'like' signifies the command to be invoked.                                                       #
  # It also makes it apparent that an extension to LIKE needs to be standardise. Works only for       #
  # PostgreSQL specfific extensions. If MySql were to add its own extension to the standard SQL then  #
  # this gem would cease to work.                                                                     #  
  #                                                                                                   #
  # METHODS:                                                                                          # 
  #                                                                                                   #
  # tune_my_query - Adds the command_type to to an instance variable namely, @command_type            #
  #                                                                                                   #
  # standardise_sql - Checks if PostgreSQLAdapter is used only then runs the conditions through the   #
  #                   Command. if not leaves the conditions untouched                                 #
  #                                                                                                   #
  #                                                                                                   #  
  module ClassMethods    
    def tune_my_query(command_type)
       @command_type = command_type      
    end
    
    def standardise_sql(*conditions)
      if @command_type
        conditions = conditions.dup
        @adapter = connection && !connection.class.to_s.include?("PostgreSQLAdapter")
        command = "#{@command_type.to_s.camelize}Command".constantize
        if @adapter      
          conditions.each { |condition| command.execute(condition) }
        end
      end
      super_merge_conditions(*conditions)
    end    
  end
  
end