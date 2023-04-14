# Nighty

Nighty is a sleep app designed to help you fall asleep faster and wake up feeling refreshed. You can also follow other people and check their sleep activities.

# Setup

The command below will do the following:

- Install dependencies
- Prepare database
- Populate users

```sh
$ ./bin/setup
```

Tested using Ruby 3.2.2

# Endpoints

## Pagination

For endpoints that support pagination, it adds the `Link` in the response headers.

METHOD | PATH
-------|-----
**POST** | `/v1/me/sleep`

### Request Body Schema

*N/A*

### Response Body Schema

```json
{
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "id": {
        "type": "integer"
      },
      "slept_at": {
        "type": "string",
        "format": "datetime"
      },
      "woke_up_at": {
        "type": "string",
        "format": "datetime",
        "nullable": true
      }
    }
  }
}
```

*NOTE: This only returns the last 20 activities.*

METHOD | PATH
-------|-----
**POST** | `/v1/me/wake_up`

### Request Body Schema

*N/A*

### Response Body Schema

```json
{
  "type": "object",
  "properties": {
    "id": {
      "type": "integer"
    },
    "slept_at": {
      "type": "string",
      "format": "datetime"
    },
    "woke_up_at": {
      "type": "string",
      "format": "datetime"
    }
  }
}
```

METHOD | PATH | PAGINATED
-------|----- | ----------
**`GET`** | `/v1/me/analytics` | ✅

### Response Body Schema

```json
{
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "id": {
        "type": "integer"
      },
      "user": {
        "type": "string"
      },
      "duration": {
        "type": "string"
      }
    }
  }
}
```

METHOD | PATH | PAGINATED
-------|----- | ----------
**`GET`** | `/v1/me/activities` | ✅

### Response Body Schema

```json
{
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "id": {
        "type": "integer"
      },
      "slept_at": {
        "type": "string",
        "format": "datetime"
      },
      "woke_up_at": {
        "type": "string",
        "format": "datetime",
        "nullable": true
      }
    }
  }
}
```

METHOD | PATH
-------|-----
**`POST`** | `/v1/users/:user_id/follows`

### Request Params

NAME | DESCRIPTION
-----|-------------
`user_id` | The ID of the user to follow

### Response Body Schema

```json
{
  "type": "object",
  "properties": {
    "ok": {
      "const": true
    }
  }
}
```

METHOD | PATH
-------|-----
**`DELETE`** | `/v1/users/:user_id/follows`

### Request Params

NAME | DESCRIPTION
-----|-------------
`user_id` | The ID of the user to unfollow

### Response Body Schema

```json
{
  "type": "object",
  "properties": {
    "ok": {
      "const": true
    }
  }
}
```
METHOD | PATH | PAGINATED
-------|----- | ----------
**`GET`** | `/v1/users/:user_id/activities` | ✅

### Request Params

NAME | DESCRIPTION
-----|-------------
`user_id` | The ID of the user to list their activities

### Response Body Schema

```json
{
  "type": "array",
  "items": {
    "type": "object",
    "properties": {
      "id": {
        "type": "integer"
      },
      "slept_at": {
        "type": "string",
        "format": "datetime"
      },
      "woke_up_at": {
        "type": "string",
        "format": "datetime",
        "nullable": true
      }
    }
  }
}
```
