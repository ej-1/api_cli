#### TODOS

#### General

- Responses could be cached, but maybe the data would become stale quickly for these types of data.
- Merging JSON strings could be discussed. Not for every call though, since it slows things down.
- Other API endpoints would be better to query a specific users for example.

#### need additional tests fro DriftrockCli.

- what if there are multiple users that are most loyal. Should all be output?

- what should happen if no user are there to be loyal yet? Edge case probably.

- what if there are multiple items that are most sold. Should all be output?

- what should happen if no products yet? Edge case probably.

- Need a integration test. Might need to pass in ApiClient to DriftrockCli to make test easier. Not doing cause of time limitation in challenge.

#### ApiClient

- Need to write a test for the get method.

#### DriftrockCli

- need to write test for handle_response method.
- could move ApiClient out of the DriftrockCli class to make it easier to tests.

####

- More comments exists in the code.
