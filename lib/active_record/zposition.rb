module ActiveRecord
  module ZPosition
    def self.included(base)
      base.extend(ClassMethods)
    end
    
    
    module ClassMethods
      def z_position(options = {})
        configuration = { :column => "position", :scope => "1 = 1", debug: false }
        configuration.update(options) if options.is_a?(Hash)

        if configuration[:debug]
          logger.info "ZPosition--------------- current z_position"
        end
        
        class_eval <<-EOV
        include ActiveRecord::ZPosition::InstanceMethods
        #default_scope order('#{configuration[:column]} ASC')
        
        def configuration
          #{configuration}
        end
        
        def position_column
          '#{configuration[:column]}'
        end

        before_create :position_to_bottom
        EOV
      end
    end

    module InstanceMethods
      def position_to_bottom
        if configuration[:debug]
          logger.info "ZPosition--------------- current position_to_bottom"
        end
        self[position_column] = bottom_position + 1
      end
      
      def move_to_top
        if configuration[:debug]
          logger.info "ZPosition--------------- current move_to_top"
        end
        return false if !in_list? || first_item?
        self.update_attribute(position_column, top_position - 1)
      end
      
      def move_to_up
        if configuration[:debug]
          logger.info "ZPosition--------------- current move_to_up"
        end
        return false if !in_list? || first_item?
        if prev_item = elder_sister_item
          prev_position = prev_item[position_column].to_i
          #如果有妹妹节点，并且小于自己则调换，否则自减
          if prev_position < current_position
            if configuration[:debug]
              logger.info "ZPosition--------------- current move_to_up--------------- exchange position"
            end
            prev_item.update_attribute(position_column, current_position)
            self.update_attribute(position_column, prev_position)
          else
            if configuration[:debug]
              logger.info "ZPosition--------------- current move_to_up--------------- update position reduce"
            end
            self.update_attribute(position_column, current_position - 1)
          end
        else
          if configuration[:debug]
            logger.info "ZPosition--------------- current move_to_up--------------- update position reduce"
          end
          self.update_attribute(position_column, current_position - 1)
        end
      end
      
      def move_to_down
        if configuration[:debug]
          logger.info "ZPosition--------------- current move_to_down"
        end
        return false if !in_list? && last_item?
        if next_item = younger_sister_item
          next_position = next_item[position_column].to_i
          #如果有姐姐节点，并且大于自己则调换，否则自增
          if next_position > current_position
            if configuration[:debug]
              logger.info "ZPosition--------------- current move_to_up--------------- exchange position"
            end
            next_item.update_attribute(position_column, current_position)
            self.update_attribute(position_column, next_position)
          else
            if configuration[:debug]
              logger.info "ZPosition--------------- current move_to_up--------------- update position increase"
            end
            self.update_attribute(position_column, current_position + 1)
          end
        else
          if configuration[:debug]
            logger.info "ZPosition--------------- current move_to_up--------------- update position increase"
          end
          self.update_attribute(position_column, current_position + 1)
        end
      end
      
      def move_to_bottom
        if configuration[:debug]
          logger.info "ZPosition--------------- current position_to_bottom"
        end
        return false if !in_list? && last_item?
        self.update_attribute(position_column, bottom_position + 1)
      end
      
      private
      def current_position
        self[position_column].to_i
      end
      
      def top_position
        if configuration[:debug]
          logger.info "ZPosition--------------- current top_position"
        end
        if item = self.class.order("#{position_column} ASC").first
          return item[position_column].to_i
        end
        return 0
      end
      
      def elder_sister_item
        if configuration[:debug]
          logger.info "ZPosition--------------- current elder_sister_item?"
        end
        self.class.where("#{position_column} < :position", {position: current_position}).order("#{position_column} DESC").first
      end
      
      def younger_sister_item
        if configuration[:debug]
          logger.info "ZPosition--------------- current younger_sister_item?"
        end
        self.class.where("#{position_column} > :position", {position: current_position}).order("#{position_column} ASC").first
      end
      
      def bottom_position
        if configuration[:debug]
          logger.info "ZPosition--------------- current bottom_position"
        end
        if item = self.class.order("#{position_column} DESC").first
          return item[position_column].to_i
        end
        return 0
      end
      
      def in_list?
        if configuration[:debug]
          logger.info "ZPosition--------------- current in_list?"
        end
        self[position_column].present?
      end
      
      def first_item?
        if configuration[:debug]
          logger.info "ZPosition--------------- current first_item?"
        end
        self.class.exists?("#{position_column} <= #{current_position}")
      end
      
      def last_item?
        if configuration[:debug]
          logger.info "ZPosition--------------- current in_list?"
        end
        self.class.exists?("#{position_column} >= #{current_position}")
      end
    end
    
    
    
    
    
    
    
  end
end




