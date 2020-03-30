class Error(Exception):
    """Base class for other exceptions"""

    pass


class NoResultsException(Error):
    """Raised when no ami results are returned."""

    pass
