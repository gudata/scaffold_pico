class <%= @controller_class_name %> < ApplicationController

  def index
    <%=
      fast_arel = ["#{@namespace}::#{@pico_class_name}"]
      fast_arel << [ "includes(#{@includes.join(', ')})" ] if @includes and !@includes.empty?
      fast_arel << [ "joins(#{@joins.join(', ')})" ] if @joins and !@joins.empty?
      fast_arel << [ "all" ]
      "@#{@collection_name} = #{fast_arel.join('.')}"
    %>
  end

  def show
    @<%= @resource_name %> = <%= @namespaced_resource_class_name %>.find(params[:id])
  end

  def new
    @<%= @resource_name %> = <%= @namespaced_resource_class_name %>.new
  end

  def edit
    @<%= @resource_name %> = <%= @namespaced_resource_class_name %>.find(params[:id])
  end

  def create
    @<%= @resource_name %> = <%= @namespaced_resource_class_name %>.new(params[:company_ownership].permit!)

    respond_to do |format|
      if @<%= @resource_name %>.save
        <%= "message = t('success_create', scope: [:active_record, :notices, :success], model: #{@resource_class_name}.model_name.human.mb_chars.downcase)" %>
        format.html { redirect_to <%= @collection_path %>, notice: message }
      else
        format.html { render :new }
      end
    end
  end

  def update
    @<%= @resource_name %> = <%= @namespaced_resource_class_name %>.find(params[:id])
    respond_to do |format|
      if @<%= @resource_name %>.update(params[:company_ownership].permit!)
        <%= "message = t('success_update', scope: [:active_record, :notices, :success], model: #{@resource_class_name}.model_name.human.mb_chars.downcase)" %>
        format.html { redirect_to <%= @collection_path %>, notice: message }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @<%= @resource_name %> = <%= @namespaced_resource_class_name %>.find(params[:id])
    @<%= @resource_name %>.destroy
    respond_to do |format|
      <%= "message = t('success_destroy', scope: [:active_record, :notices, :success], model: #{@resource_class_name}.model_name.human.mb_chars.downcase)" %>
      format.html { redirect_to <%= @collection_path %>, notice: message }
    end
  end

end
