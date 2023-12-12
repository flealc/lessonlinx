module ApplicationHelper
  def default_meta_tags
    {
      site: "LessonLinx",
      image: image_url('landing-tag.png'),
      description: "Your students, one tap away",
      og: {
        title: "LessonLinx",
        url: "https://lessonlinx.pro",
        image: image_url('landing-tag.png'),
        description: "Your students, one tap away",
        site_name: "LessonLinx"
      },
      twitter: {
        card: "summary_large_image",
        url: "https://lessonlinx.pro",
        title: "LessonLinx",
        description: "Your students, one tap away",
        image: image_url('landing-tag.png')
      }
    }
  end
end
