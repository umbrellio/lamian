# frozen_string_literal: true

module Lamian
  # Current lamian vewrsion
  #
  # format: 'a.b.c' with possible suffixes such as alpha
  # * a is for major version, it is guaranteed to be changed
  #   if back-compatibility of public API is broken
  # * b is for minor version, it is guaranteed to be changed
  #   on public API changes and also if private API
  #   back-compatibility is broken
  # * c is for incremental version, it is updated in other cases
  # According to this, it is enought to specify '~> a.b'
  # if private API was not used and to specify '~> a.b.c' if it was

  VERSION = "1.3.0"
end
