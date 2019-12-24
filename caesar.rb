#!/usr/bin/ruby

# Date: 2019/12/21
# Author: Devon Chen

=begin

    This program encrypts or decrypts data based on rotation cipher

=end

require 'optparse'

def translate_char(c, s, i)
    # param c: character to shift
    # param s: number of times to shift
    # param i: include special characters during the shift or not
    #
    # Given character c, shift s times. If i is true, include special
    # characters during the shift; otherwise, only shift letters.

    shift = ->(a, b) {
        v = (((c.ord - a.ord) + s) % (b.ord - a.ord + 1)) + a.ord
        return v.chr
    }

    cc = c

    if i
        a, b = 32.chr, 126.chr

        if c >= a and c <= b
            cc = shift.call a, b
        end
    else
        if c >= 'A' and c <= 'Z'
            cc = shift.call 'A', 'Z'
        elsif c >= 'a' and c <= 'z'
            cc = shift.call 'a', 'z'
        end
    end

    cc
end

def translate_str str, s, i
    arr = str.scan(/./).map do |c|
        translate_char c, s, i
    end

    arr.join ''
end

def parse_arg args
    arg_dict = {}
    arg_dict[:special] = false
    arg_dict[:file] = false

    parser = OptionParser.new do |opts|
        opts.banner = "Usage: #{$0} [options] [[TARGET STRING]]\n" \
            "\tIf [-f|-file] is set, [TARGET STRING] can be omitted\n\n"

        opts.on('-e', '--encrypt', 'encryption mode') do
            arg_dict[:mode] = :e
        end

        opts.on('-d', '--decrypt', 'decrypt mode') do
            arg_dict[:mode] = :d
        end

        opts.on('-s', '--shift [NUMBER]', 'shift [NUMBER] times') do |n|
            arg_dict[:shift] = n.to_i
        end

        opts.on('-i', '--include-special', 'include special characters in the shift') do
            arg_dict[:special] = true
        end

        opts.on('-f', '--file [STRING]', 'read from file [STRING]') do |fname|
            if fname.nil?
                puts "File name needs to be provided"
                exit 1
            end

            if !File.file? fname
                puts "File #{fname} does not exist"
                exit 1
            end

            arg_dict[:file] = true
            arg_dict[:content] = fname
        end

        opts.on_tail('-h', '--help', 'display help message and exit') do
            puts opts
            exit
        end
    end

    parser.parse!(args)

    if arg_dict[:mode].nil?
        puts "Mode not selected"
        exit 1
    end

    if arg_dict[:shift].nil?
        puts "Shift not set. Set to default=3"
        arg_dict[:shift] = 3
    end

    if !arg_dict[:file]
        arg_dict[:content] = args[0] || ""
    end

    arg_dict
end

arguments = parse_arg ARGV

if arguments[:mode] == :d
    arguments[:shift] *= -1
end

if arguments[:file]
    open(arguments[:content], 'r').each do |line|
        puts translate_str line, arguments[:shift], arguments[:special]
    end
else
    puts translate_str arguments[:content], arguments[:shift], arguments[:special]
end
