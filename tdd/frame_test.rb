require 'minitest/autorun'
require_relative 'frame'

class FrameTest < MiniTest::Unit::TestCase
    def test_all_gutter_game
        frame = Frame.new
        frame.record_shot(0)
        frame.record_shot(0)
        assert_equal 0, frame.score
    end

    def test_one_pin_a_play
        frame = Frame.new
        frame.record_shot(1)
        frame.record_shot(1)
        assert_equal 2, frame.score
    end

    def test_frame_finished_after_second_throw
        frame = Frame.new
        frame.record_shot(1)
        refute frame.finished?, "2投目OK"
        frame.record_shot(1)
        assert frame.finished?, "2投したので終了"
    end

    def test_10pins_get_to_finish_frame
        frame = Frame.new
        frame.record_shot(10)
        assert frame.finished?, "すでに10ピン倒したので終了"
    end

    def test_spare
        frame = Frame.new
        frame.record_shot(5)
        refute frame.spare?, "1投目なのでスペアじゃない"
        frame.record_shot(5)
        assert frame.spare?, "2投目で10ピン倒したのでスペア"
    end

    def test_strike
        frame = Frame.new
        refute frame.strike?, "気が早すぎる"
        frame.record_shot(10)
        assert frame.strike?, "1投目で10ピン倒したのでストライク"
    end

    def test_add_on_bonus
        frame = Frame.new
        frame.record_shot(5)
        frame.record_shot(5)
        frame.add_bonus(5)
        assert_equal 15, frame.score
    end
    
    def test_no_bonus_on_open_frame
        frame = Frame.new
        frame.record_shot(3)
        frame.record_shot(3)
        refute frame.need_bonus?
    end

    def test_only_one_bonus_after_spare
        frame = Frame.new
        frame.record_shot(5)
        frame.record_shot(5)
        assert frame.need_bonus?, "付与前"
        frame.add_bonus(5)
        refute frame.need_bonus?, "付与後"
    end

    def test_two_bonus_after_strike
        frame = Frame.new
        frame.record_shot(10)
        frame.add_bonus(5)
        assert frame.need_bonus?, "付与1回目"
        frame.add_bonus(5)
        refute frame.need_bonus?, "付与2回目"
    end
end