class ManimSlides < Formula
  include Language::Python::Virtualenv

  desc "Tool for live presentations using either Manim (community edition) or ManimGL."
  homepage "https://github.com/jeertmans/manim-slides"
  url "https://files.pythonhosted.org/packages/7d/ef/c79c66d52021b592e22d801ea18f418caee90fa69e7459155598a2782ec2/manim_slides-5.5.2.tar.gz"
  sha256 "4c8d39b5387c2a77a34ceae5d740194ee53d2c9c0251ed30e0c55a3ac91f542c"
  license "MIT"

  depends_on "manim"

  def install
    virtualenv_install_with_resources

    generate_completions_from_executable(bin/"manim-slides", shell_parameter_format: :click)
  end

  test do
    (testpath/"basic_example.py").write <<~PYTHON
        from manim import *  # or: from manimlib import *

        from manim_slides import Slide

        class BasicExample(Slide):
            def construct(self):
                circle = Circle(radius=3, color=BLUE)
                dot = Dot()

                self.play(GrowFromCenter(circle))
                self.next_slide()  # Waits user to press continue to go to the next slide

                self.next_slide(loop=True)  # Start loop
                self.play(MoveAlongPath(dot, circle), run_time=2, rate_func=linear)
                self.next_slide()  # This will start a new non-looping slide

                self.play(dot.animate.move_to(ORIGIN))
    PYTHON
    system bin/"manim-slides", "render", testpath/"basic_example.py", "BasicExample"
  end
end
