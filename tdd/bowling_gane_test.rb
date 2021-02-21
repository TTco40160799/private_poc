require 'minitest/autorun'
require_relative 'bowling_game'

class BowlingGameTest < MiniTest::Unit::TestCase
    def setup
        @game = BowlingGame.new
    end

    def test_all_gutter_game
        record_many_shots(20, 0)
        assert_equal 0, @game.score
    end

    def test_one_pin_a_play
        record_many_shots(20, 1)
        assert_equal 20, @game.score
    end

    def test_calc_pins_when_spare
        @game.record_shot(3)
        @game.record_shot(7)#10 + 4 = 14
        @game.record_shot(4)
        record_many_shots(17, 0)
        assert_equal 18, @game.score, "total"
        assert_equal 14, @game.frame_score(1), "frame:1"
    end

    def test_spare_logic
        @game.record_shot(2)
        @game.record_shot(5)
        @game.record_shot(5)
        @game.record_shot(1)
        record_many_shots(16, 0)
        assert_equal 13, @game.score
    end

    def test_calc_pins_when_strike
        @game.record_shot(10)
        @game.record_shot(3)
        @game.record_shot(3)
        @game.record_shot(1)
        record_many_shots(15, 0)
        assert_equal 23, @game.score, "total"
        assert_equal 16, @game.frame_score(1), "frames:1"
    end

    def test_calc_when_double
        @game.record_shot(10)
        @game.record_shot(10)
        @game.record_shot(3)
        @game.record_shot(1)
        record_many_shots(14, 0)
        assert_equal 41, @game.score
        assert_equal 23, @game.frame_score(1), "frames:1"
        assert_equal 14, @game.frame_score(2), "frames:2"
    end

    def test_calc_when_turkey
        @game.record_shot(10)
        @game.record_shot(10)
        @game.record_shot(10)
        @game.record_shot(3)
        @game.record_shot(1)
        record_many_shots(12, 0)
        assert_equal 71, @game.score
    end

    def test_calc_when_spare_after_strike
        @game.record_shot(10)
        @game.record_shot(5)
        @game.record_shot(5)
        @game.record_shot(3)
        record_many_shots(15, 0)
        assert_equal 36, @game.score
    end

    def test_calc_when_spare_after_double
        @game.record_shot(10)
        @game.record_shot(10)
        @game.record_shot(5)
        @game.record_shot(5)
        @game.record_shot(3)
        record_many_shots(13, 0)
        assert_equal 61, @game.score
    end

    def test_score_1st_in_all_gurter
        record_many_shots(20, 0)
        assert_equal 0, @game.frame_score(1)
    end

    def test_score_2_in_all_frame_with_a_pin_a_play
        record_many_shots(20, 1)
        10.times do |i|
            frame_no = i + 1
            assert_equal 2, @game.frame_score(frame_no)
        end
    end

    private

    def record_many_shots(count, pins)
        count.times do
            @game.record_shot(pins)
        end
    end
end