class Api::V1::ApplicationController < ApplicationController
  before_filter :build_object, only: [:create]
  before_filter :display_object, :process_search, only: [:index]
  before_filter :load_object, only: [:show, :destroy, :update]

  PATH_MAP = {
    users: {
      index: ["name" ,"email"],
      create: ["name", "password", "email", "role"],
      destroy: ["id"],
      update: ["name", "email", "password"],
    },
    orders: {
      index: ["status", "address"]
    },
    order_items: {
      index: ["order_id", "user_id"]
    },
    menu_items: {
      index: ["menu_item_id", "menu_item_name"]
    },
    menu_categories: {
      index: ["name", "status"]
    },
  }

  SET_CONDITION_DEFAULTS = {
      orders: { archive: false}
  }


  SET_OPERATORS = {
    users: {
      index: {
        name: {op: "LIKE"},
        email: {op: "LIKE"}
      },
      create: ["name", "password", "email", "role"],
      destroy: ["id"],
      update: ["name", "email", "password"],
    },
    orders: {
      index: {
        status: {op: "="}, 
        address: {op: "LIKE"},
        archive: {op: "="}
      }
    },
    order_items: {
    index: {
      order_id:{op:"=="}, 
      user_id:{op:"=="}
      }
    },
    menu_items: {
      index: {
        menu_item_id:{op:"=="},
        menu_item_name:{op:"LIKE"}
      }
    },
    menu_categories: {
      index: {
        name:{op:"LIKE"}, 
        status:{op:"=="}
      }
    }
  }




  def initialize
    @limit = 1
    @offset = 0
  end

  def build_object
    @build_params = send("#{cname}_params")
    if cname == "order"
      @build_params = @build_params.merge(archive:false)
    end
    if @build_params.kind_of?(Hash)
      @item = model.new(@build_params)
      @item
    end
  end

  def display_object
    puts "++++++++====++++++++++++++++++++++++++++++++display"
    unless params[:limit].nil? && params[:offset].nil?
      @limit = Integer(params[:limit])
      @offset = Integer(params[:offset])
    end
  end

  def process_search
    default_condition = SET_CONDITION_DEFAULTS[controller_name.to_sym]
    @condition = default_condition.nil? ? {} : default_condition 
    allowed_field = PATH_MAP[controller_name.to_sym][params[:action].to_sym]
    search_keys = params.select { |k, v| allowed_field.include?(k) }
    search_keys.each do |k, v|
      @condition[k] = v;
    end
    @condition = @condition.map{|k,v| "#{k} #{SET_OPERATORS[controller_name.to_sym][params[:action].to_sym][k.to_sym][:op]} '%#{v}%' "}.join(" and ")#"name LIKE  ? and email like ?,ananya,ananya@g.com
  end

  def load_object
    @item = model.find(params[:id])
  end

  def cname
    controller_name.singularize #user User
  end

  def mname
    controller_name.classify.constantize #users=>user=>User
  end

  def model
    cname.capitalize.constantize #User
  end

end
