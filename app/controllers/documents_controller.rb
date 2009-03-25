#===============================================================================
class DocumentsController < ApplicationController

  before_filter :get_menu_items
  #-----------------------------------------------------------------------------
  def get_menu_items
    @menu_items = DocType.view_all
    @documents_count = Document.count
  end

  # GET /documents
  # GET /documents.xml
  #-----------------------------------------------------------------------------
  def index
    if @doc_type_filter = params[:doc_type]
      @documents = Document.find_all_by_doc_type(@doc_type_filter)
      @keys = MetaKey.view_all(:startkey=>[@doc_type_filter], :endkey=>[@doc_type_filter,"\u9999"]).map{|mk| mk.key[1]}.uniq.sort
    else
      @documents = Document.find(:all)
      @keys=MetaKey.view_all.map{|mk| mk.key[1]}.uniq.sort
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @documents }
    end
  end

  # GET /documents/1
  # GET /documents/1.xml
  #-----------------------------------------------------------------------------
  def show
    @document = Document.find(params[:id])
    @document_html = @document.to_html

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @document }
    end
  end

  #  # GET /documents/new
  #  # GET /documents/new.xml
  #  #-----------------------------------------------------------------------------
  def new
    @document = Document.new(:doc_type=>params[:doc_type])
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @document }
    end
  end

  # GET /documents/1/edit
  #-----------------------------------------------------------------------------
  def edit
    @document = Document.find(params[:id])
  end

  # POST /documents
  # POST /documents.xml
  #-----------------------------------------------------------------------------
  def create
    @document = Document.new(params[:document])

    respond_to do |format|
      if @document.save
        flash[:notice] = 'Document was successfully created.'
        format.html { redirect_to(@document) }
        format.xml  { render :xml => @document, :status => :created, :location => @document }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /documents/1
  # PUT /documents/1.xml
  #-----------------------------------------------------------------------------
  def update
    @document = Document.find(params[:id])
    attribs = params[:document]
    attribs[:meta] = params[:meta].to_hash if  params[:meta]  # Document.meta est de type Hash et non HashWithIndifferentAccess
    attribs[:meta] = {} if params[:design_mode]
    if params[:is_model]
      # Génération d'un nouveau doc final à partir d'un modèle
      @document = Document.new(attribs)
    else
      # Modification  d'un document final ou d'un modèle
      @document.attributes = attribs
    end
#    @document.meta2content
#    @document.content2meta

    respond_to do |format|
      if @document.save
        flash[:notice] = 'Document was successfully updated.'
        format.html { redirect_to(@document) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @document.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.xml
  #-----------------------------------------------------------------------------
  def destroy
    @document = Document.find(params[:id])
    @document.destroy

    respond_to do |format|
      format.html { redirect_to(documents_url) }
      format.xml  { head :ok }
    end
  end
end
