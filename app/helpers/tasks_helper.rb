module TasksHelper
  def has_duplicate_tag_names?
    _params = params[:task][:tags_attributes].to_unsafe_hash.uniq {|e| e[1]}
    if _params.length != params[:task][:tags_attributes].to_unsafe_hash.length
      flash[:warning] = "Tag names can not be repeated. "
      true
    else
      false
    end
  end
end
