# frozen_string_literal: true

require_relative 'frame'
require_relative 'score'

class Game
  def initialize(score)
    score = Score.new(score) # scoreの中身は何かあまり気にせず、newすると良い感じに変換されているイメージを持つ
    @frames = score.scores.each_slice(2).map do |s|
      Frame.new(s) # ボウリングのフレームは１投目&2投目のペアなのは明確なので、このデータ構造を知っているのは問題ないと思う
    end
  end

  # 外部から使う際は、「game.total_point」のように、気持ちよく呼べる
  def total_point
    calc_total_frames
  end

  private

  def calc_total_frames
    total_frames_point = 0
    @frames.each_with_index do |frame, index|
      total_frames_point += frame.total_shots

      if index < 9 # 最終フレームだけは最初のみ計算するので除外する
        if frame.shots[0] == 10 # ストライクの場合
          total_frames_point += @frames[index + 1].total_shots # 次のフレームの合計を足す
          total_frames_point += @frames[index + 2].shots[0] if @frames[index + 1].shots[0] == 10
        elsif frame.total_shots == 10 # スペアの場合
          total_frames_point += @frames[index + 1].shots[0]
        end
      end
    end
    total_frames_point
  end
end
