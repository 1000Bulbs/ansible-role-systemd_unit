# molecule/default/tests/test_default.py
import pytest

systemd_unit_name = "example"
systemd_unit_type = "service"
systemd_unit_file = f"/etc/systemd/system/{systemd_unit_name}.{systemd_unit_type}"


@pytest.mark.parametrize("path", [systemd_unit_file])
def test_unit_file_exists(host, path):
    f = host.file(path)
    assert f.exists
    assert f.user == "root"
    assert f.group == "root"
    assert f.mode == 0o644


def test_unit_file_contents(host):
    f = host.file(systemd_unit_file)
    content = f.content_string
    assert "[Unit]" in content
    assert "Description=Example Service" in content
    assert "After=network.target" in content
    assert "[Service]" in content
    assert (
        "ExecStart=/bin/bash -c 'while true; do echo \"running\"; sleep 60; done'"
        in content
    )
    assert "Restart=always" in content
    assert "[Install]" in content
    assert "WantedBy=multi-user.target" in content


def test_service_is_enabled_and_running(host):
    svc = host.service(systemd_unit_name)
    assert svc.is_enabled
    assert svc.is_running
