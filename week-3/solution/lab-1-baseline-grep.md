 of `base_url`.
.venv/Lib/site-packages/langchain_openai/chat_models/base.py:3628:                base_url="http://localhost:8000/v1",
.venv/Lib/site-packages/langchain_openai/chat_models/base.py:3668:            base_url="http://localhost:8000/v1",
.venv/Lib/site-packages/langchain_openai/chat_models/base.py:3799:        if self.openai_api_base:
.venv/Lib/site-packages/langchain_openai/chat_models/base.py:3800:            attributes["openai_api_base"] = self.openai_api_base
.venv/Lib/site-packages/langchain_openai/chat_models/codex.py:212:`base_url` (and its `openai_api_base` alias) is also pinned — to
.venv/Lib/site-packages/langchain_openai/chat_models/codex.py:363:        # Pin `base_url` (and its legacy `openai_api_base` alias) to the Codex
.venv/Lib/site-packages/langchain_openai/chat_models/codex.py:365:        # caller-controlled `base_url` would otherwise exfiltrate the token to
.venv/Lib/site-packages/langchain_openai/chat_models/codex.py:368:        for key in ("base_url", "openai_api_base"):
.venv/Lib/site-packages/langchain_openai/chat_models/codex.py:394:        # (raise-don't-rewrite, mirroring the `base_url` handling above). An
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:389:    base_url: str | None,
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:394:        "base_url": base_url
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:410:    base_url: str | None,
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:415:        "base_url": base_url
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:483:    base_url: str | None,
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:487:    return _build_sync_httpx_client(base_url, timeout, socket_options)
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:492:    base_url: str | None,
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:496:    return _build_async_httpx_client(base_url, timeout, socket_options)
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:500:    base_url: str | None,
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:511:        return _build_sync_httpx_client(base_url, timeout, socket_options)
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:513:        return _cached_sync_httpx_client(base_url, timeout, socket_options)
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:517:    base_url: str | None,
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:528:        return _build_async_httpx_client(base_url, timeout, socket_options)
.venv/Lib/site-packages/langchain_openai/chat_models/_client_utils.py:530:        return _cached_async_httpx_client(base_url, timeout, socket_options)
Binary file .venv/Lib/site-packages/langchain_openai/chat_models/__pycache__/azure.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/langchain_openai/chat_models/__pycache__/base.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/langchain_openai/chat_models/__pycache__/_client_utils.cpython-312.pyc matches
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:158:    validate_base_url: bool = True
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:166:        # between azure_endpoint and base_url (openai_api_base).
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:167:        openai_api_base = self.openai_api_base
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:168:        if openai_api_base and self.validate_base_url:
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:169:            # Only validate openai_api_base if azure_endpoint is not provided
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:170:            if not self.azure_endpoint and "/openai" not in openai_api_base:
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:171:                self.openai_api_base = cast(str, self.openai_api_base) + "/openai"
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:174:                    "the `azure_endpoint` param not `openai_api_base` "
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:175:                    "(or alias `base_url`). "
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:182:                    "`openai_api_base` (or alias `base_url`) should not be. "
.venv/Lib/site-packages/langchain_openai/embeddings/azure.py:199:            "base_url": self.openai_api_base,
.venv/Lib/site-packages/langchain_openai/embeddings/base.py:176:            base_url="...",
.venv/Lib/site-packages/langchain_openai/embeddings/base.py:209:    openai_api_base: str | None = Field(
.venv/Lib/site-packages/langchain_openai/embeddings/base.py:210:        alias="base_url", default_factory=from_env("OPENAI_API_BASE", default=None)
.venv/Lib/site-packages/langchain_openai/embeddings/base.py:217:    1. Explicit `base_url` (or `openai_api_base`) kwarg.
.venv/Lib/site-packages/langchain_openai/embeddings/base.py:399:            "base_url": self.openai_api_base,
Binary file .venv/Lib/site-packages/langchain_openai/embeddings/__pycache__/azure.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/langchain_openai/embeddings/__pycache__/base.cpython-312.pyc matches
.venv/Lib/site-packages/langchain_openai/llms/azure.py:94:    validate_base_url: bool = True
.venv/Lib/site-packages/langchain_openai/llms/azure.py:95:    """For backwards compatibility. If legacy val openai_api_base is passed in, try to
.venv/Lib/site-packages/langchain_openai/llms/azure.py:96:        infer if it is a base_url or azure_endpoint and update accordingly.
.venv/Lib/site-packages/langchain_openai/llms/azure.py:140:        # between azure_endpoint and base_url (openai_api_base).
.venv/Lib/site-packages/langchain_openai/llms/azure.py:141:        openai_api_base = self.openai_api_base
.venv/Lib/site-packages/langchain_openai/llms/azure.py:142:        if openai_api_base and self.validate_base_url:
.venv/Lib/site-packages/langchain_openai/llms/azure.py:143:            if "/openai" not in openai_api_base:
.venv/Lib/site-packages/langchain_openai/llms/azure.py:144:                self.openai_api_base = (
.venv/Lib/site-packages/langchain_openai/llms/azure.py:145:                    cast(str, self.openai_api_base).rstrip("/") + "/openai"
.venv/Lib/site-packages/langchain_openai/llms/azure.py:149:                    "the `azure_endpoint` param not `openai_api_base` "
.venv/Lib/site-packages/langchain_openai/llms/azure.py:150:                    "(or alias `base_url`)."
.venv/Lib/site-packages/langchain_openai/llms/azure.py:157:                    "`openai_api_base` (or alias `base_url`) should not be. "
.venv/Lib/site-packages/langchain_openai/llms/azure.py:175:            "base_url": self.openai_api_base,
.venv/Lib/site-packages/langchain_openai/llms/base.py:98:        openai_api_base:
.venv/Lib/site-packages/langchain_openai/llms/base.py:126:            # openai_api_base="...",
.venv/Lib/site-packages/langchain_openai/llms/base.py:210:    openai_api_base: str | None = Field(
.venv/Lib/site-packages/langchain_openai/llms/base.py:211:        alias="base_url", default_factory=from_env("OPENAI_API_BASE", default=None)
.venv/Lib/site-packages/langchain_openai/llms/base.py:218:    1. Explicit `base_url` (or `openai_api_base`) kwarg.
.venv/Lib/site-packages/langchain_openai/llms/base.py:344:            "base_url": self.openai_api_base,
.venv/Lib/site-packages/langchain_openai/llms/base.py:818:        base_url:
.venv/Lib/site-packages/langchain_openai/llms/base.py:836:            # base_url="...",
.venv/Lib/site-packages/langchain_openai/llms/base.py:910:        if self.openai_api_base:
.venv/Lib/site-packages/langchain_openai/llms/base.py:911:            attributes["openai_api_base"] = self.openai_api_base
Binary file .venv/Lib/site-packages/langchain_openai/llms/__pycache__/azure.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/langchain_openai/llms/__pycache__/base.cpython-312.pyc matches
.venv/Lib/site-packages/langgraph_sdk/stream/transport/base.py:69:def build_websocket_url(base_url: httpx.URL, path: str) -> str:
.venv/Lib/site-packages/langgraph_sdk/stream/transport/base.py:71:    scheme = "wss" if base_url.scheme == "https" else "ws"
.venv/Lib/site-packages/langgraph_sdk/stream/transport/base.py:72:    base_path = base_url.path.rstrip("/")
.venv/Lib/site-packages/langgraph_sdk/stream/transport/base.py:75:    return str(base_url.copy_with(scheme=scheme, path=full_path, query=None))
.venv/Lib/site-packages/langgraph_sdk/stream/transport/sync_ws.py:75:        url = build_websocket_url(self._client.base_url, self._stream_path)
.venv/Lib/site-packages/langgraph_sdk/stream/transport/sync_ws.py:146:    requests, scoping the result to `client.base_url` + `path`.
.venv/Lib/site-packages/langgraph_sdk/stream/transport/sync_ws.py:150:    target = client.base_url.copy_with(path=path)
.venv/Lib/site-packages/langgraph_sdk/stream/transport/ws.py:87:                url = build_websocket_url(self._client.base_url, self._stream_path)
.venv/Lib/site-packages/langgraph_sdk/stream/transport/ws.py:216:    requests, scoping the result to `client.base_url` + `path`.
.venv/Lib/site-packages/langgraph_sdk/stream/transport/ws.py:220:    target = client.base_url.copy_with(path=path)
.venv/Lib/site-packages/langgraph_sdk/_async/client.py:131:        base_url=url,
.venv/Lib/site-packages/langgraph_sdk/_async/http.py:170:            _validate_reconnect_location(self.client.base_url, loc)
.venv/Lib/site-packages/langgraph_sdk/_async/http.py:250:                        self.client.base_url, reconnect_location
.venv/Lib/site-packages/langgraph_sdk/_shared/utilities.py:167:def _validate_reconnect_location(base_url: httpx.URL, location: str) -> str:
.venv/Lib/site-packages/langgraph_sdk/_shared/utilities.py:178:    base_scheme = str(base_url.scheme)
.venv/Lib/site-packages/langgraph_sdk/_shared/utilities.py:181:        str(base_url.host),
.venv/Lib/site-packages/langgraph_sdk/_shared/utilities.py:182:        base_url.port or _default_port(base_scheme),
.venv/Lib/site-packages/langgraph_sdk/_sync/client.py:77:        base_url=url,
.venv/Lib/site-packages/langgraph_sdk/_sync/http.py:170:            _validate_reconnect_location(self.client.base_url, loc)
.venv/Lib/site-packages/langgraph_sdk/_sync/http.py:252:                        self.client.base_url, reconnect_location
.venv/Lib/site-packages/langsmith/async_client.py:30:from langsmith.client import _get_openapi_base_url
.venv/Lib/site-packages/langsmith/async_client.py:279:            base_url=api_url, headers=_headers, timeout=timeout_
.venv/Lib/site-packages/langsmith/async_client.py:327:            base_url=_get_openapi_base_url(str(self._client.base_url)),
.venv/Lib/site-packages/langsmith/async_client.py:437:        return str(self._client.base_url)
.venv/Lib/site-packages/langsmith/async_client.py:1729:        base_url = f"/annotation-queues/{ls_client._as_uuid(queue_id, 'queue_id')}/run"
.venv/Lib/site-packages/langsmith/async_client.py:1730:        response = await self._arequest_with_retries("GET", f"{base_url}/{index}")
.venv/Lib/site-packages/langsmith/client.py:174:def _get_openapi_base_url(api_url: str) -> str:
.venv/Lib/site-packages/langsmith/client.py:1624:            base_url = _get_openapi_base_url(self.api_url)
.venv/Lib/site-packages/langsmith/client.py:1629:                    base_url=base_url,
.venv/Lib/site-packages/langsmith/client.py:1636:                base_url=base_url,
.venv/Lib/site-packages/langsmith/client.py:1645:            base_url = _get_openapi_base_url(self.api_url)
.venv/Lib/site-packages/langsmith/client.py:1650:                    base_url=base_url,
.venv/Lib/site-packages/langsmith/client.py:1657:                base_url=base_url,
.venv/Lib/site-packages/langsmith/client.py:9347:        base_url = f"/annotation-queues/{_as_uuid(queue_id, 'queue_id')}"
.venv/Lib/site-packages/langsmith/client.py:9350:            f"{base_url}",
.venv/Lib/site-packages/langsmith/client.py:9503:        base_url = f"/annotation-queues/{_as_uuid(queue_id, 'queue_id')}/run"
.venv/Lib/site-packages/langsmith/client.py:9506:            f"{base_url}/{index}",
.venv/Lib/site-packages/langsmith/evaluation/_arunner.py:1269:            base_url = project_url.split("/projects/p/")[0]
.venv/Lib/site-packages/langsmith/evaluation/_arunner.py:1271:                f"{base_url}/datasets/{dataset_id}/compare?"
.venv/Lib/site-packages/langsmith/evaluation/_runner.py:593:            base_url = project_url.split("/projects/p/")[0]
.venv/Lib/site-packages/langsmith/evaluation/_runner.py:595:                f"{base_url}/datasets/{self._manager.dataset_id}/compare?"
.venv/Lib/site-packages/langsmith/evaluation/_runner.py:1084:    base_url = project_url.split("/projects/p/")[0]
.venv/Lib/site-packages/langsmith/evaluation/_runner.py:1086:        f"{base_url}/datasets/{dataset_id}/compare?"
.venv/Lib/site-packages/langsmith/evaluation/_runner.py:1376:            base_url = project_url.split("/projects/p/")[0]
.venv/Lib/site-packages/langsmith/evaluation/_runner.py:1378:                f"{base_url}/datasets/{dataset_id}/compare?"
.venv/Lib/site-packages/langsmith/integrations/otel/processor.py:91:        base_url = ls_utils.get_api_url(None)
.venv/Lib/site-packages/langsmith/integrations/otel/processor.py:92:        # Ensure base_url ends with / for proper joining
.venv/Lib/site-packages/langsmith/integrations/otel/processor.py:93:        if not base_url.endswith("/"):
.venv/Lib/site-packages/langsmith/integrations/otel/processor.py:94:            base_url += "/"
.venv/Lib/site-packages/langsmith/integrations/otel/processor.py:95:        endpoint = url or urljoin(base_url, "otel/v1/traces")
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:125:        self._base_url = (api_endpoint or _get_default_api_endpoint()).rstrip("/")
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:145:        if self._base_url.endswith(suffix):
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:146:            return self._base_url[: -len(suffix)]
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:147:        return self._base_url
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:173:                base_url=self._api_root(),
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:205:            api_endpoint=self._base_url,
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:255:        return f"AsyncSandboxClient (API URL: {self._base_url})"
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:457:        url = f"{self._base_url}/boxes"
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:528:        url = _box_url(self._base_url, name)
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:552:        url = f"{self._base_url}/boxes"
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:616:        url = _box_url(self._base_url, name)
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:664:        url = _box_url(self._base_url, name)
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:697:        url = _box_url(self._base_url, name, "status")
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:777:        url = _box_url(self._base_url, name, "service-url")
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:854:        url = _box_url(self._base_url, name, "download-url")
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:947:        url = _box_url(self._base_url, name, "start")
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:973:        url = _box_url(self._base_url, name, "stop")
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:1022:        url = f"{self._base_url}/snapshots"
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:1177:        url = _box_url(self._base_url, sandbox_name, "snapshot")
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:1224:        url = f"{self._base_url}/snapshots/{_quote_reference_segment(snapshot_id)}"
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:1254:        url = f"{self._base_url}/snapshots-by-name/{_quote_path_segment(name)}"
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:1300:        url = f"{self._base_url}/snapshots"
.venv/Lib/site-packages/langsmith/sandbox/_async_client.py:1340:        url = f"{self._base_url}/snapshots/{_quote_path_segment(snapshot_id)}"
.venv/Lib/site-packages/langsmith/sandbox/_client.py:100:def _box_url(base_url: str, name: str, *segments: str) -> str:
.venv/Lib/site-packages/langsmith/sandbox/_client.py:103:    return f"{base_url}/boxes/{_quote_path_segment(name)}{suffix}"
.venv/Lib/site-packages/langsmith/sandbox/_client.py:249:        self._base_url = (api_endpoint or _get_default_api_endpoint()).rstrip("/")
.venv/Lib/site-packages/langsmith/sandbox/_client.py:269:        if self._base_url.endswith(suffix):
.venv/Lib/site-packages/langsmith/sandbox/_client.py:270:            return self._base_url[: -len(suffix)]
.venv/Lib/site-packages/langsmith/sandbox/_client.py:271:        return self._base_url
.venv/Lib/site-packages/langsmith/sandbox/_client.py:297:                base_url=self._api_root(),
.venv/Lib/site-packages/langsmith/sandbox/_client.py:331:            api_endpoint=self._base_url,
.venv/Lib/site-packages/langsmith/sandbox/_client.py:373:        return f"SandboxClient (API URL: {self._base_url})"
.venv/Lib/site-packages/langsmith/sandbox/_client.py:583:        url = f"{self._base_url}/boxes"
.venv/Lib/site-packages/langsmith/sandbox/_client.py:650:        url = _box_url(self._base_url, name)
.venv/Lib/site-packages/langsmith/sandbox/_client.py:670:        url = f"{self._base_url}/boxes"
.venv/Lib/site-packages/langsmith/sandbox/_client.py:739:        url = _box_url(self._base_url, name)
.venv/Lib/site-packages/langsmith/sandbox/_client.py:783:        url = _box_url(self._base_url, name)
.venv/Lib/site-packages/langsmith/sandbox/_client.py:814:        url = _box_url(self._base_url, name, "status")
.venv/Lib/site-packages/langsmith/sandbox/_client.py:893:        url = _box_url(self._base_url, name, "service-url")
.venv/Lib/site-packages/langsmith/sandbox/_client.py:970:        url = _box_url(self._base_url, name, "download-url")
.venv/Lib/site-packages/langsmith/sandbox/_client.py:1063:        url = _box_url(self._base_url, name, "start")
.venv/Lib/site-packages/langsmith/sandbox/_client.py:1089:        url = _box_url(self._base_url, name, "stop")
.venv/Lib/site-packages/langsmith/sandbox/_client.py:1148:        url = f"{self._base_url}/snapshots"
.venv/Lib/site-packages/langsmith/sandbox/_client.py:1308:        url = _box_url(self._base_url, sandbox_name, "snapshot")
.venv/Lib/site-packages/langsmith/sandbox/_client.py:1353:        url = f"{self._base_url}/snapshots/{_quote_reference_segment(snapshot_id)}"
.venv/Lib/site-packages/langsmith/sandbox/_client.py:1383:        url = f"{self._base_url}/snapshots-by-name/{_quote_path_segment(name)}"
.venv/Lib/site-packages/langsmith/sandbox/_client.py:1429:        url = f"{self._base_url}/snapshots"
.venv/Lib/site-packages/langsmith/sandbox/_client.py:1469:        url = f"{self._base_url}/snapshots/{_quote_path_segment(snapshot_id)}"
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:365:    _base_url: URL
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:376:        base_url: str | URL,
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:384:        self._base_url = self._enforce_trailing_slash(URL(base_url))
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:462:        Merge a URL argument together with any 'base_url' on the client,
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:468:            merge_raw_path = self.base_url.raw_path + merge_url.raw_path.lstrip(b"/")
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:469:            return self.base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:703:    def base_url(self) -> URL:
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:704:        return self._base_url
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:706:    @base_url.setter
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:707:    def base_url(self, url: URL | str) -> None:
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:708:        self._base_url = self._enforce_trailing_slash(url if isinstance(url, URL) else URL(url))
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:852:        base_url: str | URL,
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:882:            base_url=base_url,
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:889:            base_url=base_url,
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:1435:        base_url: str | URL,
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:1463:            base_url=base_url,
.venv/Lib/site-packages/langsmith/_openapi_client/_base_client.py:1472:            base_url=base_url,
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:83:        base_url: str | httpx.URL | None = None,
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:116:        if base_url is None:
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:117:            base_url = os.environ.get("LANGCHAIN_BASE_URL")
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:118:        if base_url is None:
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:119:            base_url = f"https://api.smith.langchain.com/"
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:132:            base_url=base_url,
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:259:        base_url: str | httpx.URL | None = None,
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:294:            base_url=base_url or self.base_url,
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:351:        base_url: str | httpx.URL | None = None,
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:384:        if base_url is None:
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:385:            base_url = os.environ.get("LANGCHAIN_BASE_URL")
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:386:        if base_url is None:
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:387:            base_url = f"https://api.smith.langchain.com/"
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:400:            base_url=base_url,
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:527:        base_url: str | httpx.URL | None = None,
.venv/Lib/site-packages/langsmith/_openapi_client/_client.py:562:            base_url=base_url or self.base_url,
Binary file .venv/Lib/site-packages/langsmith/_openapi_client/__pycache__/_base_client.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/langsmith/_openapi_client/__pycache__/_client.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/langsmith/__pycache__/client.cpython-312.pyc matches
.venv/Lib/site-packages/langsmith-0.14.1.dist-info/METADATA:507:# We will only use examples from the top level AgentExecutor run here,
.venv/Lib/site-packages/openai/auth/_x509.py:269:def x509_data_residency_base_url(
.venv/Lib/site-packages/openai/auth/_x509.py:270:    base_url: httpx2.URL | str | None,
.venv/Lib/site-packages/openai/auth/_x509.py:275:        return base_url
Binary file .venv/Lib/site-packages/openai/auth/__pycache__/_x509.cpython-312.pyc matches
.venv/Lib/site-packages/openai/lib/azure.py:149:            if model is not None and "/deployments" not in str(self.base_url.path):
.venv/Lib/site-packages/openai/lib/azure.py:191:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:213:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:227:        base_url: str,
.venv/Lib/site-packages/openai/lib/azure.py:235:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:260:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:261:        base_url: str | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:319:        if base_url is None:
.venv/Lib/site-packages/openai/lib/azure.py:325:                    "Must provide one of the `base_url` or `azure_endpoint` arguments, or the `AZURE_OPENAI_ENDPOINT` environment variable"
.venv/Lib/site-packages/openai/lib/azure.py:329:                base_url = f"{azure_endpoint.rstrip('/')}/openai/deployments/{azure_deployment}"
.venv/Lib/site-packages/openai/lib/azure.py:331:                base_url = f"{azure_endpoint.rstrip('/')}/openai"
.venv/Lib/site-packages/openai/lib/azure.py:334:                raise ValueError("base_url and azure_endpoint are mutually exclusive")
.venv/Lib/site-packages/openai/lib/azure.py:346:            base_url=base_url,
.venv/Lib/site-packages/openai/lib/azure.py:352:            websocket_base_url=websocket_base_url,
.venv/Lib/site-packages/openai/lib/azure.py:377:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:381:        base_url: str | httpx2.URL | None | NotGiven = NOT_GIVEN,
.venv/Lib/site-packages/openai/lib/azure.py:398:        base_url = None if isinstance(base_url, NotGiven) else base_url
.venv/Lib/site-packages/openai/lib/azure.py:420:            websocket_base_url=websocket_base_url,
.venv/Lib/site-packages/openai/lib/azure.py:421:            base_url=base_url,
.venv/Lib/site-packages/openai/lib/azure.py:437:        # `super().copy()` reconstructs the client from `base_url`, which does not carry the
.venv/Lib/site-packages/openai/lib/azure.py:441:        if base_url is None:
.venv/Lib/site-packages/openai/lib/azure.py:522:        if self.websocket_base_url is not None:
.venv/Lib/site-packages/openai/lib/azure.py:523:            base_url = normalize_httpx_url(self.websocket_base_url)
.venv/Lib/site-packages/openai/lib/azure.py:524:            merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/realtime"
.venv/Lib/site-packages/openai/lib/azure.py:525:            realtime_url = base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/lib/azure.py:527:            base_url = self._prepare_url("/realtime")
.venv/Lib/site-packages/openai/lib/azure.py:528:            realtime_url = base_url.copy_with(scheme="wss")
.venv/Lib/site-packages/openai/lib/azure.py:549:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:572:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:586:        base_url: str,
.venv/Lib/site-packages/openai/lib/azure.py:595:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:620:        base_url: str | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:621:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:679:        if base_url is None:
.venv/Lib/site-packages/openai/lib/azure.py:685:                    "Must provide one of the `base_url` or `azure_endpoint` arguments, or the `AZURE_OPENAI_ENDPOINT` environment variable"
.venv/Lib/site-packages/openai/lib/azure.py:689:                base_url = f"{azure_endpoint.rstrip('/')}/openai/deployments/{azure_deployment}"
.venv/Lib/site-packages/openai/lib/azure.py:691:                base_url = f"{azure_endpoint.rstrip('/')}/openai"
.venv/Lib/site-packages/openai/lib/azure.py:694:                raise ValueError("base_url and azure_endpoint are mutually exclusive")
.venv/Lib/site-packages/openai/lib/azure.py:706:            base_url=base_url,
.venv/Lib/site-packages/openai/lib/azure.py:712:            websocket_base_url=websocket_base_url,
.venv/Lib/site-packages/openai/lib/azure.py:737:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/azure.py:741:        base_url: str | httpx2.URL | None | NotGiven = NOT_GIVEN,
.venv/Lib/site-packages/openai/lib/azure.py:758:        base_url = None if isinstance(base_url, NotGiven) else base_url
.venv/Lib/site-packages/openai/lib/azure.py:780:            websocket_base_url=websocket_base_url,
.venv/Lib/site-packages/openai/lib/azure.py:781:            base_url=base_url,
.venv/Lib/site-packages/openai/lib/azure.py:797:        # `super().copy()` reconstructs the client from `base_url`, which does not carry the
.venv/Lib/site-packages/openai/lib/azure.py:801:        if base_url is None:
.venv/Lib/site-packages/openai/lib/azure.py:884:        if self.websocket_base_url is not None:
.venv/Lib/site-packages/openai/lib/azure.py:885:            base_url = normalize_httpx_url(self.websocket_base_url)
.venv/Lib/site-packages/openai/lib/azure.py:886:            merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/realtime"
.venv/Lib/site-packages/openai/lib/azure.py:887:            realtime_url = base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/lib/azure.py:889:            base_url = self._prepare_url("/realtime")
.venv/Lib/site-packages/openai/lib/azure.py:890:            realtime_url = base_url.copy_with(scheme="wss")
.venv/Lib/site-packages/openai/lib/bedrock.py:39:    base_url: str
.venv/Lib/site-packages/openai/lib/bedrock.py:57:    uses_region_derived_base_url: bool
.venv/Lib/site-packages/openai/lib/bedrock.py:80:def _legacy_endpoint(base_url: str | httpx2.URL | None | NotGiven) -> Literal["mantle"] | None:
.venv/Lib/site-packages/openai/lib/bedrock.py:81:    configured = os.environ.get("AWS_BEDROCK_BASE_URL") if isinstance(base_url, NotGiven) else base_url
.venv/Lib/site-packages/openai/lib/bedrock.py:87:def _uses_region_derived_base_url(base_url: str | httpx2.URL | None) -> bool:
.venv/Lib/site-packages/openai/lib/bedrock.py:88:    if isinstance(base_url, str) and not base_url.strip():
.venv/Lib/site-packages/openai/lib/bedrock.py:89:        base_url = None
.venv/Lib/site-packages/openai/lib/bedrock.py:90:    if base_url is not None:
.venv/Lib/site-packages/openai/lib/bedrock.py:93:    environment_base_url = os.environ.get("AWS_BEDROCK_BASE_URL")
.venv/Lib/site-packages/openai/lib/bedrock.py:94:    return environment_base_url is None or not environment_base_url.strip()
.venv/Lib/site-packages/openai/lib/bedrock.py:137:    base_url: str | httpx2.URL | None,
.venv/Lib/site-packages/openai/lib/bedrock.py:168:    uses_region_derived_base_url = _uses_region_derived_base_url(base_url)
.venv/Lib/site-packages/openai/lib/bedrock.py:170:    provider_base_url: str | httpx2.URL | None | NotGiven
.venv/Lib/site-packages/openai/lib/bedrock.py:171:    if isinstance(base_url, str) and not base_url.strip():
.venv/Lib/site-packages/openai/lib/bedrock.py:172:        provider_base_url = None
.venv/Lib/site-packages/openai/lib/bedrock.py:173:    elif base_url is None:
.venv/Lib/site-packages/openai/lib/bedrock.py:174:        provider_base_url = NOT_GIVEN
.venv/Lib/site-packages/openai/lib/bedrock.py:176:        provider_base_url = base_url
.venv/Lib/site-packages/openai/lib/bedrock.py:179:        endpoint=_legacy_endpoint(provider_base_url),
.venv/Lib/site-packages/openai/lib/bedrock.py:181:        base_url=provider_base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:204:        uses_region_derived_base_url=uses_region_derived_base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:220:    base_url: str | httpx2.URL | None,
.venv/Lib/site-packages/openai/lib/bedrock.py:249:    routing_override = aws_region is not None or base_url is not None
.venv/Lib/site-packages/openai/lib/bedrock.py:284:    restores_region_derived_base_url = isinstance(base_url, str) and not base_url.strip()
.venv/Lib/site-packages/openai/lib/bedrock.py:288:        and not restores_region_derived_base_url
.venv/Lib/site-packages/openai/lib/bedrock.py:289:        and (base_url is not None or not state.uses_region_derived_base_url)
.venv/Lib/site-packages/openai/lib/bedrock.py:295:    if base_url is not None:
.venv/Lib/site-packages/openai/lib/bedrock.py:296:        next_base_url: str | httpx2.URL | None = base_url
.venv/Lib/site-packages/openai/lib/bedrock.py:297:    elif state.uses_region_derived_base_url:
.venv/Lib/site-packages/openai/lib/bedrock.py:298:        next_base_url = ""
.venv/Lib/site-packages/openai/lib/bedrock.py:300:        next_base_url = client.base_url
.venv/Lib/site-packages/openai/lib/bedrock.py:311:        "base_url": next_base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:331:        base_url=str(client.base_url),
.venv/Lib/site-packages/openai/lib/bedrock.py:348:            endpoint=_legacy_endpoint(client.base_url),
.venv/Lib/site-packages/openai/lib/bedrock.py:350:            base_url=client.base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:355:            endpoint=_legacy_endpoint(client.base_url),
.venv/Lib/site-packages/openai/lib/bedrock.py:357:            base_url=client.base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:362:        endpoint=_legacy_endpoint(client.base_url),
.venv/Lib/site-packages/openai/lib/bedrock.py:364:        base_url=client.base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:375:    base_url_changed = str(client.base_url) != previous_signature.base_url
.venv/Lib/site-packages/openai/lib/bedrock.py:377:    if base_url_changed:
.venv/Lib/site-packages/openai/lib/bedrock.py:378:        client._bedrock_state = replace(client._bedrock_state, uses_region_derived_base_url=False)
.venv/Lib/site-packages/openai/lib/bedrock.py:379:        client._uses_region_derived_base_url = False
.venv/Lib/site-packages/openai/lib/bedrock.py:386:        if client._bedrock_state.uses_region_derived_base_url and client.aws_region is not None:
.venv/Lib/site-packages/openai/lib/bedrock.py:387:            client.base_url = f"https://bedrock-mantle.{client.aws_region}.api.aws/openai/v1"
.venv/Lib/site-packages/openai/lib/bedrock.py:417:    _uses_region_derived_base_url: bool
.venv/Lib/site-packages/openai/lib/bedrock.py:435:        base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/bedrock.py:436:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/bedrock.py:458:                base_url=base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:473:            websocket_base_url=websocket_base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:486:        self._uses_region_derived_base_url = _state.uses_region_derived_base_url
.venv/Lib/site-packages/openai/lib/bedrock.py:487:        canonical_endpoint = _parse_bedrock_endpoint_hostname(self.base_url.host)
.venv/Lib/site-packages/openai/lib/bedrock.py:552:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/bedrock.py:553:        base_url: str | httpx2.URL | None | NotGiven = NOT_GIVEN,
.venv/Lib/site-packages/openai/lib/bedrock.py:567:        base_url = None if isinstance(base_url, NotGiven) else base_url
.venv/Lib/site-packages/openai/lib/bedrock.py:600:            base_url=base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:607:            "websocket_base_url": websocket_base_url if websocket_base_url is not None else self.websocket_base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:629:                base_url="" if self._bedrock_state.uses_region_derived_base_url else self.base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:653:    _uses_region_derived_base_url: bool
.venv/Lib/site-packages/openai/lib/bedrock.py:671:        base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/bedrock.py:672:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/bedrock.py:694:                base_url=base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:709:            websocket_base_url=websocket_base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:722:        self._uses_region_derived_base_url = _state.uses_region_derived_base_url
.venv/Lib/site-packages/openai/lib/bedrock.py:723:        canonical_endpoint = _parse_bedrock_endpoint_hostname(self.base_url.host)
.venv/Lib/site-packages/openai/lib/bedrock.py:790:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/lib/bedrock.py:791:        base_url: str | httpx2.URL | None | NotGiven = NOT_GIVEN,
.venv/Lib/site-packages/openai/lib/bedrock.py:805:        base_url = None if isinstance(base_url, NotGiven) else base_url
.venv/Lib/site-packages/openai/lib/bedrock.py:838:            base_url=base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:845:            "websocket_base_url": websocket_base_url if websocket_base_url is not None else self.websocket_base_url,
.venv/Lib/site-packages/openai/lib/bedrock.py:867:                base_url="" if self._bedrock_state.uses_region_derived_base_url else self.base_url,
Binary file .venv/Lib/site-packages/openai/lib/__pycache__/azure.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/openai/lib/__pycache__/bedrock.cpython-312.pyc matches
.venv/Lib/site-packages/openai/providers/bedrock.py:38:def _normalize_base_url(base_url: str | httpx2.URL) -> httpx2.URL:
.venv/Lib/site-packages/openai/providers/bedrock.py:39:    url = normalize_httpx_url(base_url)
.venv/Lib/site-packages/openai/providers/bedrock.py:83:    base_url: httpx2.URL, *, endpoint: BedrockEndpoint, region: str | None
.venv/Lib/site-packages/openai/providers/bedrock.py:85:    canonical_endpoint = _parse_bedrock_endpoint_hostname(base_url.host)
.venv/Lib/site-packages/openai/providers/bedrock.py:90:    if base_url.scheme != "https":
.venv/Lib/site-packages/openai/providers/bedrock.py:103:def _default_bedrock_base_url(endpoint: BedrockEndpoint, region: str) -> httpx2.URL:
.venv/Lib/site-packages/openai/providers/bedrock.py:109:    return _normalize_base_url(f"https://{hostname}/openai/v1")
.venv/Lib/site-packages/openai/providers/bedrock.py:142:    def __init__(self, token_provider: BedrockTokenProvider, *, base_url: httpx2.URL) -> None:
.venv/Lib/site-packages/openai/providers/bedrock.py:144:        self._base_url = base_url
.venv/Lib/site-packages/openai/providers/bedrock.py:148:        if not _same_origin(request.url, self._base_url):
.venv/Lib/site-packages/openai/providers/bedrock.py:198:        base_url: httpx2.URL,
.venv/Lib/site-packages/openai/providers/bedrock.py:202:        self._base_url = base_url
.venv/Lib/site-packages/openai/providers/bedrock.py:207:        if not _same_origin(request.url, self._base_url):
.venv/Lib/site-packages/openai/providers/bedrock.py:273:    configured_base_url: httpx2.URL | None
.venv/Lib/site-packages/openai/providers/bedrock.py:346:            base_url = self.configured_base_url or _default_bedrock_base_url(self.endpoint, region)
.venv/Lib/site-packages/openai/providers/bedrock.py:347:            _validate_canonical_bedrock_endpoint(base_url, endpoint=self.endpoint, region=region)
.venv/Lib/site-packages/openai/providers/bedrock.py:348:            auth = _BedrockSigV4Auth(config=aws_config, base_url=base_url, auth=aws_auth)
.venv/Lib/site-packages/openai/providers/bedrock.py:350:        if self.configured_base_url is not None:
.venv/Lib/site-packages/openai/providers/bedrock.py:351:            base_url = self.configured_base_url
.venv/Lib/site-packages/openai/providers/bedrock.py:353:            base_url = _default_bedrock_base_url(self.endpoint, region)
.venv/Lib/site-packages/openai/providers/bedrock.py:361:            auth = _BedrockBearerAuth(bearer_provider, base_url=base_url)
.venv/Lib/site-packages/openai/providers/bedrock.py:367:                base_url=base_url,
.venv/Lib/site-packages/openai/providers/bedrock.py:376:            base_url=base_url,
.venv/Lib/site-packages/openai/providers/bedrock.py:387:    base_url: str | httpx2.URL | None | NotGiven = NOT_GIVEN,
.venv/Lib/site-packages/openai/providers/bedrock.py:408:    configured_base_url: httpx2.URL | None
.venv/Lib/site-packages/openai/providers/bedrock.py:409:    if isinstance(base_url, NotGiven):
.venv/Lib/site-packages/openai/providers/bedrock.py:410:        environment_base_url = _normalize_optional_string(os.environ.get("AWS_BEDROCK_BASE_URL"))
.venv/Lib/site-packages/openai/providers/bedrock.py:411:        configured_base_url = _normalize_base_url(environment_base_url) if environment_base_url else None
.venv/Lib/site-packages/openai/providers/bedrock.py:412:    elif base_url is None:
.venv/Lib/site-packages/openai/providers/bedrock.py:413:        configured_base_url = None
.venv/Lib/site-packages/openai/providers/bedrock.py:415:        if isinstance(base_url, str) and not base_url.strip():
.venv/Lib/site-packages/openai/providers/bedrock.py:416:            raise OpenAIError("The Bedrock `base_url` must not be empty.")
.venv/Lib/site-packages/openai/providers/bedrock.py:417:        configured_base_url = _normalize_base_url(base_url)
.venv/Lib/site-packages/openai/providers/bedrock.py:420:        _parse_bedrock_endpoint_hostname(configured_base_url.host) if configured_base_url is not None else None
.venv/Lib/site-packages/openai/providers/bedrock.py:473:    if normalized_region is None and (configured_base_url is None or not (explicit_bearer or use_environment_bearer)):
.venv/Lib/site-packages/openai/providers/bedrock.py:481:    if configured_base_url is not None:
.venv/Lib/site-packages/openai/providers/bedrock.py:482:        _validate_canonical_bedrock_endpoint(configured_base_url, endpoint=resolved_endpoint, region=normalized_region)
.venv/Lib/site-packages/openai/providers/bedrock.py:489:            configured_base_url=configured_base_url,
Binary file .venv/Lib/site-packages/openai/providers/__pycache__/bedrock.cpython-312.pyc matches
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:369:                    **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:398:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:399:            base_url = normalize_httpx_url(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:401:            base_url = self.__client._base_url.copy_with(scheme="wss")
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:403:        merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/realtime"
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:404:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:552:                    **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:581:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:582:            base_url = normalize_httpx_url(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:584:            base_url = self.__client._base_url.copy_with(scheme="wss")
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:586:        merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/realtime"
.venv/Lib/site-packages/openai/resources/beta/realtime/realtime.py:587:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:4647:                **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:4686:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:4687:            base_url = normalize_httpx_url(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:4689:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:4691:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:4693:        merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/responses"
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:4694:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:5133:                **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:5172:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:5173:            base_url = normalize_httpx_url(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:5175:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:5177:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:5179:        merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/responses"
.venv/Lib/site-packages/openai/resources/beta/responses/responses.py:5180:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/live/forks.py:551:                **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/live/forks.py:590:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/live/forks.py:591:            base_url = httpx2.URL(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/live/forks.py:593:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/live/forks.py:595:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/live/forks.py:597:        merge_raw_path = base_url.raw_path.rstrip(b"/") + path_template(
.venv/Lib/site-packages/openai/resources/live/forks.py:600:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/live/forks.py:1038:                **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/live/forks.py:1077:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/live/forks.py:1078:            base_url = httpx2.URL(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/live/forks.py:1080:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/live/forks.py:1082:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/live/forks.py:1084:        merge_raw_path = base_url.raw_path.rstrip(b"/") + path_template(
.venv/Lib/site-packages/openai/resources/live/forks.py:1087:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/live/live.py:770:                **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/live/live.py:809:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/live/live.py:810:            base_url = httpx2.URL(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/live/live.py:812:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/live/live.py:814:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/live/live.py:816:        merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/live/sessions"
.venv/Lib/site-packages/openai/resources/live/live.py:817:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/live/live.py:1252:                **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/live/live.py:1291:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/live/live.py:1292:            base_url = httpx2.URL(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/live/live.py:1294:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/live/live.py:1296:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/live/live.py:1298:        merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/live/sessions"
.venv/Lib/site-packages/openai/resources/live/live.py:1299:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/live/sideband.py:558:                **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/live/sideband.py:598:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/live/sideband.py:599:            base_url = httpx2.URL(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/live/sideband.py:601:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/live/sideband.py:603:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/live/sideband.py:605:        merge_raw_path = base_url.raw_path.rstrip(b"/") + path_template(
.venv/Lib/site-packages/openai/resources/live/sideband.py:608:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/live/sideband.py:1050:                **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/live/sideband.py:1090:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/live/sideband.py:1091:            base_url = httpx2.URL(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/live/sideband.py:1093:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/live/sideband.py:1095:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/live/sideband.py:1097:        merge_raw_path = base_url.raw_path.rstrip(b"/") + path_template(
.venv/Lib/site-packages/openai/resources/live/sideband.py:1100:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:726:                    **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:768:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:769:            base_url = normalize_httpx_url(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:771:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:773:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:775:        merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/realtime"
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:776:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:1235:                    **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:1277:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:1278:            base_url = normalize_httpx_url(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:1280:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:1282:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:1284:        merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/realtime"
.venv/Lib/site-packages/openai/resources/realtime/realtime.py:1285:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/responses/responses.py:4494:                **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/responses/responses.py:4533:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/responses/responses.py:4534:            base_url = normalize_httpx_url(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/responses/responses.py:4536:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/responses/responses.py:4538:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/responses/responses.py:4540:        merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/responses"
.venv/Lib/site-packages/openai/resources/responses/responses.py:4541:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/resources/responses/responses.py:4992:                **self.__client.base_url.params,
.venv/Lib/site-packages/openai/resources/responses/responses.py:5031:        if self.__client.websocket_base_url is not None:
.venv/Lib/site-packages/openai/resources/responses/responses.py:5032:            base_url = normalize_httpx_url(self.__client.websocket_base_url)
.venv/Lib/site-packages/openai/resources/responses/responses.py:5034:            scheme = self.__client._base_url.scheme
.venv/Lib/site-packages/openai/resources/responses/responses.py:5036:            base_url = self.__client._base_url.copy_with(scheme=ws_scheme)
.venv/Lib/site-packages/openai/resources/responses/responses.py:5038:        merge_raw_path = base_url.raw_path.rstrip(b"/") + b"/responses"
.venv/Lib/site-packages/openai/resources/responses/responses.py:5039:        return base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/_base_client.py:447:    _base_url: URL
.venv/Lib/site-packages/openai/_base_client.py:458:        base_url: str | URL,
.venv/Lib/site-packages/openai/_base_client.py:466:        self._base_url = self._enforce_trailing_slash(normalize_httpx_url(base_url))
.venv/Lib/site-packages/openai/_base_client.py:561:        Merge a URL argument together with any 'base_url' on the client,
.venv/Lib/site-packages/openai/_base_client.py:567:            merge_raw_path = self.base_url.raw_path + merge_url.raw_path.lstrip(b"/")
.venv/Lib/site-packages/openai/_base_client.py:568:            return self.base_url.copy_with(raw_path=merge_raw_path)
.venv/Lib/site-packages/openai/_base_client.py:798:    def base_url(self) -> URL:
.venv/Lib/site-packages/openai/_base_client.py:799:        return self._base_url
.venv/Lib/site-packages/openai/_base_client.py:801:    @base_url.setter
.venv/Lib/site-packages/openai/_base_client.py:802:    def base_url(self, url: URL | str) -> None:
.venv/Lib/site-packages/openai/_base_client.py:803:        self._base_url = self._enforce_trailing_slash(normalize_httpx_url(url))
.venv/Lib/site-packages/openai/_base_client.py:971:        base_url: str | URL,
.venv/Lib/site-packages/openai/_base_client.py:1007:            base_url=base_url,
.venv/Lib/site-packages/openai/_base_client.py:1014:            base_url=base_url,
.venv/Lib/site-packages/openai/_base_client.py:1595:        base_url: str | URL,
.venv/Lib/site-packages/openai/_base_client.py:1629:            base_url=base_url,
.venv/Lib/site-packages/openai/_base_client.py:1638:            base_url=base_url,
.venv/Lib/site-packages/openai/_client.py:43:    x509_data_residency_base_url,
.venv/Lib/site-packages/openai/_client.py:136:    _base_url_was_default: bool
.venv/Lib/site-packages/openai/_client.py:140:    websocket_base_url: str | httpx2.URL | None
.venv/Lib/site-packages/openai/_client.py:150:    def base_url(self) -> httpx2.URL:
.venv/Lib/site-packages/openai/_client.py:151:        return self._base_url
.venv/Lib/site-packages/openai/_client.py:153:    @base_url.setter
.venv/Lib/site-packages/openai/_client.py:154:    def base_url(self, url: httpx2.URL | str) -> None:
.venv/Lib/site-packages/openai/_client.py:158:        self._base_url = self._enforce_trailing_slash(normalized_url)
.venv/Lib/site-packages/openai/_client.py:159:        self._base_url_was_default = False
.venv/Lib/site-packages/openai/_client.py:172:        base_url: str | httpx2.URL | None | NotGiven = not_given,
.venv/Lib/site-packages/openai/_client.py:174:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/_client.py:205:        `base_url`, `websocket_base_url`, or `provider`.
.venv/Lib/site-packages/openai/_client.py:207:        base_url = resolve_data_residency(
.venv/Lib/site-packages/openai/_client.py:208:            data_residency, base_url, provider=provider, websocket_base_url=websocket_base_url
.venv/Lib/site-packages/openai/_client.py:210:        base_url = x509_data_residency_base_url(base_url, data_residency, workload_identity)
.venv/Lib/site-packages/openai/_client.py:220:                    ("base_url", base_url),
.venv/Lib/site-packages/openai/_client.py:290:        self.websocket_base_url = websocket_base_url
.venv/Lib/site-packages/openai/_client.py:304:            base_url = provider_runtime.base_url
.venv/Lib/site-packages/openai/_client.py:305:        elif base_url is None:
.venv/Lib/site-packages/openai/_client.py:306:            base_url = os.environ.get("OPENAI_BASE_URL")
.venv/Lib/site-packages/openai/_client.py:307:        self._base_url_was_default = provider_runtime is None and base_url is None
.venv/Lib/site-packages/openai/_client.py:309:        if base_url is None:
.venv/Lib/site-packages/openai/_client.py:310:            base_url = MTLS_API_BASE_URL if x509_identity is not None else "https://api.openai.com/v1"
.venv/Lib/site-packages/openai/_client.py:312:            validate_x509_api_url(base_url)
.venv/Lib/site-packages/openai/_client.py:337:            base_url=base_url,
.venv/Lib/site-packages/openai/_client.py:556:                validate_x509_api_url(request.url, expected_origin=self.base_url)
.venv/Lib/site-packages/openai/_client.py:574:                expected_origin=self.base_url,
.venv/Lib/site-packages/openai/_client.py:711:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/_client.py:712:        base_url: str | httpx2.URL | None | NotGiven = not_given,
.venv/Lib/site-packages/openai/_client.py:765:        explicit_base_url = base_url is not None and not isinstance(base_url, NotGiven)
.venv/Lib/site-packages/openai/_client.py:773:        if effective_data_residency is None and mode_changed and not explicit_base_url:
.venv/Lib/site-packages/openai/_client.py:775:        base_url = resolve_data_residency(
.venv/Lib/site-packages/openai/_client.py:777:            not_given if base_url is None and data_residency is None else base_url,
.venv/Lib/site-packages/openai/_client.py:779:            websocket_base_url=websocket_base_url,
.venv/Lib/site-packages/openai/_client.py:781:        base_url = x509_data_residency_base_url(base_url, effective_data_residency, next_workload_identity)
.venv/Lib/site-packages/openai/_client.py:782:        preserve_default_base_url = False
.venv/Lib/site-packages/openai/_client.py:790:                "base_url": base_url,
.venv/Lib/site-packages/openai/_client.py:797:                "base_url": base_url,
.venv/Lib/site-packages/openai/_client.py:800:            inherited_base_url = None if mode_changed and self._base_url_was_default else self.base_url
.venv/Lib/site-packages/openai/_client.py:801:            preserve_default_base_url = base_url is None and not mode_changed and self._base_url_was_default
.venv/Lib/site-packages/openai/_client.py:808:                "base_url": base_url or inherited_base_url,
.venv/Lib/site-packages/openai/_client.py:815:            websocket_base_url=None if data_residency is not None else websocket_base_url or self.websocket_base_url,
.venv/Lib/site-packages/openai/_client.py:825:        if preserve_default_base_url:
.venv/Lib/site-packages/openai/_client.py:826:            copied._base_url_was_default = True
.venv/Lib/site-packages/openai/_client.py:842:        elif not explicit_base_url and not provider_changed:
.venv/Lib/site-packages/openai/_client.py:896:    _base_url_was_default: bool
.venv/Lib/site-packages/openai/_client.py:900:    websocket_base_url: str | httpx2.URL | None
.venv/Lib/site-packages/openai/_client.py:910:    def base_url(self) -> httpx2.URL:
.venv/Lib/site-packages/openai/_client.py:911:        return self._base_url
.venv/Lib/site-packages/openai/_client.py:913:    @base_url.setter
.venv/Lib/site-packages/openai/_client.py:914:    def base_url(self, url: httpx2.URL | str) -> None:
.venv/Lib/site-packages/openai/_client.py:918:        self._base_url = self._enforce_trailing_slash(normalized_url)
.venv/Lib/site-packages/openai/_client.py:919:        self._base_url_was_default = False
.venv/Lib/site-packages/openai/_client.py:932:        base_url: str | httpx2.URL | None | NotGiven = not_given,
.venv/Lib/site-packages/openai/_client.py:934:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/_client.py:965:        `base_url`, `websocket_base_url`, or `provider`.
.venv/Lib/site-packages/openai/_client.py:967:        base_url = resolve_data_residency(
.venv/Lib/site-packages/openai/_client.py:968:            data_residency, base_url, provider=provider, websocket_base_url=websocket_base_url
.venv/Lib/site-packages/openai/_client.py:970:        base_url = x509_data_residency_base_url(base_url, data_residency, workload_identity)
.venv/Lib/site-packages/openai/_client.py:980:                    ("base_url", base_url),
.venv/Lib/site-packages/openai/_client.py:1050:        self.websocket_base_url = websocket_base_url
.venv/Lib/site-packages/openai/_client.py:1064:            base_url = provider_runtime.base_url
.venv/Lib/site-packages/openai/_client.py:1065:        elif base_url is None:
.venv/Lib/site-packages/openai/_client.py:1066:            base_url = os.environ.get("OPENAI_BASE_URL")
.venv/Lib/site-packages/openai/_client.py:1067:        self._base_url_was_default = provider_runtime is None and base_url is None
.venv/Lib/site-packages/openai/_client.py:1069:        if base_url is None:
.venv/Lib/site-packages/openai/_client.py:1070:            base_url = MTLS_API_BASE_URL if x509_identity is not None else "https://api.openai.com/v1"
.venv/Lib/site-packages/openai/_client.py:1072:            validate_x509_api_url(base_url)
.venv/Lib/site-packages/openai/_client.py:1097:            base_url=base_url,
.venv/Lib/site-packages/openai/_client.py:1316:                validate_x509_api_url(request.url, expected_origin=self.base_url)
.venv/Lib/site-packages/openai/_client.py:1334:                expected_origin=self.base_url,
.venv/Lib/site-packages/openai/_client.py:1484:        websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/_client.py:1485:        base_url: str | httpx2.URL | None | NotGiven = not_given,
.venv/Lib/site-packages/openai/_client.py:1537:        explicit_base_url = base_url is not None and not isinstance(base_url, NotGiven)
.venv/Lib/site-packages/openai/_client.py:1545:        if effective_data_residency is None and mode_changed and not explicit_base_url:
.venv/Lib/site-packages/openai/_client.py:1547:        base_url = resolve_data_residency(
.venv/Lib/site-packages/openai/_client.py:1549:            not_given if base_url is None and data_residency is None else base_url,
.venv/Lib/site-packages/openai/_client.py:1551:            websocket_base_url=websocket_base_url,
.venv/Lib/site-packages/openai/_client.py:1553:        base_url = x509_data_residency_base_url(base_url, effective_data_residency, next_workload_identity)
.venv/Lib/site-packages/openai/_client.py:1554:        preserve_default_base_url = False
.venv/Lib/site-packages/openai/_client.py:1562:                "base_url": base_url,
.venv/Lib/site-packages/openai/_client.py:1569:                "base_url": base_url,
.venv/Lib/site-packages/openai/_client.py:1572:            inherited_base_url = None if mode_changed and self._base_url_was_default else self.base_url
.venv/Lib/site-packages/openai/_client.py:1573:            preserve_default_base_url = base_url is None and not mode_changed and self._base_url_was_default
.venv/Lib/site-packages/openai/_client.py:1580:                "base_url": base_url or inherited_base_url,
.venv/Lib/site-packages/openai/_client.py:1587:            websocket_base_url=None if data_residency is not None else websocket_base_url or self.websocket_base_url,
.venv/Lib/site-packages/openai/_client.py:1597:        if preserve_default_base_url:
.venv/Lib/site-packages/openai/_client.py:1598:            copied._base_url_was_default = True
.venv/Lib/site-packages/openai/_client.py:1614:        elif not explicit_base_url and not provider_changed:
.venv/Lib/site-packages/openai/_data_residency.py:24:    base_url: str | httpx2.URL | None | NotGiven,
.venv/Lib/site-packages/openai/_data_residency.py:27:    websocket_base_url: str | httpx2.URL | None = None,
.venv/Lib/site-packages/openai/_data_residency.py:31:        return None if isinstance(base_url, NotGiven) else base_url
.venv/Lib/site-packages/openai/_data_residency.py:32:    if not isinstance(base_url, NotGiven):
.venv/Lib/site-packages/openai/_data_residency.py:33:        raise ValueError("The `data_residency` and `base_url` arguments are mutually exclusive")
.venv/Lib/site-packages/openai/_data_residency.py:34:    if websocket_base_url is not None:
.venv/Lib/site-packages/openai/_data_residency.py:35:        raise ValueError("The `data_residency` and `websocket_base_url` arguments are mutually exclusive")
.venv/Lib/site-packages/openai/_provider.py:22:    base_url: str | httpx2.URL
.venv/Lib/site-packages/openai/__init__.py:166:base_url: str | _httpx.URL | None = None
.venv/Lib/site-packages/openai/__init__.py:257:    def base_url(self) -> _httpx.URL:
.venv/Lib/site-packages/openai/__init__.py:258:        if base_url is not None:
.venv/Lib/site-packages/openai/__init__.py:259:            return _normalize_httpx_url(base_url)
.venv/Lib/site-packages/openai/__init__.py:261:        return super().base_url
.venv/Lib/site-packages/openai/__init__.py:263:    @base_url.setter
.venv/Lib/site-packages/openai/__init__.py:264:    def base_url(self, url: _httpx.URL | str) -> None:
.venv/Lib/site-packages/openai/__init__.py:265:        super().base_url = url  # type: ignore[misc]
.venv/Lib/site-packages/openai/__init__.py:412:                base_url=base_url,
.venv/Lib/site-packages/openai/__init__.py:428:                base_url=base_url,
.venv/Lib/site-packages/openai/__init__.py:443:            base_url=base_url,
Binary file .venv/Lib/site-packages/openai/__pycache__/_base_client.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/openai/__pycache__/_client.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/openai/__pycache__/_data_residency.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/openai/__pycache__/_provider.cpython-312.pyc matches
Binary file .venv/Lib/site-packages/openai/__pycache__/__init__.cpython-312.pyc matches
.venv/Lib/site-packages/openai-3.19.2.dist-info/METADATA:250:X.509 mode defaults to `https://mtls.api.openai.com/v1` when neither `base_url`
.venv/Lib/site-packages/openai-3.19.2.dist-info/METADATA:997:    base_url="http://my.test.server.example.com:8083/v1",
.venv/Lib/site-packages/openai-3.19.2.dist-info/METADATA:1044:    base_url=os.environ.get(
.venv/Lib/site-packages/openai-3.19.2.dist-info/METADATA:1076:    base_url=os.environ.get(
.venv/Lib/site-packages/openai-3.19.2.dist-info/METADATA:1093:services or pass it through `with_options()` with a different `base_url`.
.venv/Lib/site-packages/openai-3.19.2.dist-info/METADATA:1234:Pass `base_url` to `bedrock(...)` or set `AWS_BEDROCK_BASE_URL` to override the derived `https://bedrock-mantle.<region>.api.aws/openai/v1` endpoint. Custom URLs retain Mantle signing by default; pass `endpoint="runtime"` to use Runtime signing.
.venv/Lib/site-packages/requests_toolbelt/sessions.py:15:        ...     base_url='https://example.com/resource/')
.venv/Lib/site-packages/requests_toolbelt/sessions.py:32:        ...     base_url='https://example.com/resource/')
.venv/Lib/site-packages/requests_toolbelt/sessions.py:50:        ...     base_url='https://example.com/resource/')
.venv/Lib/site-packages/requests_toolbelt/sessions.py:66:    base_url = None
.venv/Lib/site-packages/requests_toolbelt/sessions.py:68:    def __init__(self, base_url=None):
.venv/Lib/site-packages/requests_toolbelt/sessions.py:69:        if base_url:
.venv/Lib/site-packages/requests_toolbelt/sessions.py:70:            self.base_url = base_url
.venv/Lib/site-packages/requests_toolbelt/sessions.py:89:        return urljoin(self.base_url, url)