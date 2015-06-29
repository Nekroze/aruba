# @!method be_an_existing_directory
#   This matchers checks if <directory> exists in filesystem
#
#   @return [TrueClass, FalseClass] The result
#
#     false:
#     * if directory does not exist
#     true:
#     * if directory exists
#
#   @example Use matcher
#
#     RSpec.describe do
#       it { expect(directory1).to be_an_existing_directory }
#     end
RSpec::Matchers.define :be_an_existing_directory do |_|
  match do |actual|
    stop_processes!

    next false unless actual.is_a? String

    directory?(actual)
  end

  failure_message do |actual|
    format("expected that directory \"%s\" exists", actual)
  end

  failure_message_when_negated do |actual|
    format("expected that directory \"%s\" does not exist", actual)
  end
end

RSpec::Matchers.alias_matcher :an_existing_directory, :be_an_existing_directory

# @!method have_sub_directory(sub_directory)
#   This matchers checks if <directory> has given sub-directory
#
#   @param [Array] sub_directory
#      A list of sub-directory relative to current directory
#
#   @return [TrueClass, FalseClass] The result
#
#     false:
#     * if directory does not have sub-directory
#     true:
#     * if directory has sub-directory
#
#   @example Use matcher with single directory
#
#     RSpec.describe do
#       it { expect('dir1.d').to have_sub_directory('subdir.1.d') }
#     end
#
#   @example Use matcher with multiple directories
#
#     RSpec.describe do
#       it { expect('dir1.d').to have_sub_directory(['subdir.1.d', 'subdir.2.d']) }
#     end
RSpec::Matchers.define :have_sub_directory do |expected|
  match do |actual|
    next false unless directory?(actual)

    expected_files = Array(expected).map { |p| File.join(actual, p) }
    existing_files = list(actual)

    (expected_files - existing_files).empty?
  end

  diffable

  failure_message do |actual|
    format("expected that directory \"%s\" has the following sub-directories: %s.", actual, Array(expected).join(', '))
  end

  failure_message_when_negated do |actual|
    format("expected that directory \"%s\" does not have the following sub-directories: %s.", actual, Array(expected).join(', '))
  end
end
