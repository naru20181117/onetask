class SearchController < ApplicationController
  def search
    @model = params["search"]["model"]
    @content = params["search"]["content"]
    @how = params["search"]["partical"]
    @datas = partical(@model, @content)
  end

  private

  def partical(model, content)
    if model == 'task'
      Task.where("name LIKE?", "%#{content}%")
    elsif model == 'status'
      Task.where("status LIKE?", "%#{content}%")
    end
  end
end
