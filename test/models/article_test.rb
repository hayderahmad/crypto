require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  test "Failed Article saving" do
    article = Article.new(
        title: "First article",
        imageurl: "lasdkjf.com",
        source: "llkdje/kekjr",
        article_url: "lsdkje.com",
        article_id: "324lk234lk3"
    )
    assert article.save, "Failed saving the article because it is missing the body"
  end
  test "Successful Article saving" do
    article = Article.new(
        title: "First article",
        body: "first article body",
        imageurl: "lasdkjf.com",
        source: "llkdje/kekjr",
        article_url: "lsdkje.com",
        article_id: "324lk234lk3"
    )
    assert article.save, "Failed saving the article because it is missing the body"
  end
end
