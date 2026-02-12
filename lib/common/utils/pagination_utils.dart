class PaginationUtils<T> {
  final Future<T> Function(int page, int pageSize) fetchPage;
  final int pageSize;

  int _currentPage = 1;
  bool _isLoading = false;
  bool _hasMore = true;
  T? _data;

  PaginationUtils({
    required this.fetchPage,
    this.pageSize = 10,
  });

  /// Returns the current list of items
  T? get items => _data;

  /// Returns true if there are more items to load
  bool get hasMore => _hasMore;

  /// Loads the first page (use for refresh)
  Future<void> refresh() async {
    _currentPage = 1;
    _hasMore = true;
    _data = null;
    await loadNextPage();
  }

  /// Loads the next page of data
  Future<void> loadNextPage() async {
    if (_isLoading || !_hasMore) return;
    _isLoading = true;

    try {
      final T newItems = await fetchPage(_currentPage, pageSize);
      // if (newItems.isEmpty || newItems.length < pageSize) {
      //   _hasMore = false;
      // }
      _data = newItems;

      _currentPage++;
    } catch (e) {
      rethrow;
    } finally {
      _isLoading = false;
    }
  }
}
