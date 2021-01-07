"""Exception script."""


class Error(Exception):
    """Base class for other exceptions."""


class NoResultsException(Error):
    """Raised when no ami results are returned."""
