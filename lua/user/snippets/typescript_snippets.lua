local ls = require("luasnip")
local fmt = require("luasnip.extras.fmt").fmt
local rep = require("luasnip.extras").rep
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local sn = ls.snippet_node

local M = {}

local function get_line_number(args, parent)
  local position = vim.api.nvim_win_get_cursor(0)
  return tostring(position[1])
end

local function get_function_name(args, parent)
  local file_path = vim.api.nvim_buf_get_name(0)
  local file_name = file_path:match("^.+/(.+).tsx?$")
  return file_name
end

M.snippets = {
  s(
    {
      trig = "clog",
      name = "ts-console-log",
      description = "TypeScript log trace for debugging",
    },
    {
      t("console.log('** "),
      f(get_function_name),
      t(":"),
      f(get_line_number),
      t("', "),
      c(1,
        {
          fmt("'{variable_name}', typeof({variable_name_type}), JSON.stringify({variable_name_repeated})",
            {
              variable_name = i(1),
              variable_name_type = rep(1),
              variable_name_repeated = rep(1),
            }
          ),
          fmt("'{comment}'", { comment = i(1) }),
        }
      ),
      t(") // TODO camilo: remove this"),
    }
  ),

  s(
    {
      trig = "vlog",
      name = "ts-console-log-variable",
      description = "TypeScript log trace for a variable",
    },
    {
      t("console.log(`"),
      f(get_function_name),
      t(":"),
      f(get_line_number),
      t(" ${JSON.stringify("),
      i(1),
      t(")}`)"),
    }
  ),

  s(
    {
      trig = "tlog",
      name = "ts-console-log-text",
      description = "TypeScript log trace for free text",
    },
    {
      t("console.log('"),
      f(get_function_name),
      t(":"),
      f(get_line_number),
      t(" "),
      c(1, {t(""), t("Start "), t("End ")}),
      i(2),
      t("')"),
    }
  ),

  s(
    {
      trig = "ctd",
      name = "ts-todo",
      description = "Adds a TODO comment for Camilo",
    }, {
      t("// TODO camilo: "),
      i(0),
    }
  ),

  s(
    {
      trig = "ctfbase",
      name = "ts-test-file-base",
      description = "Adds the base boilerplate for test files",
    }, {
      t({
        "import { createServer } from '../app/server'",
        "import { clearDb, createTestUser } from './test-helpers'",
        "import { IServer } from '../src/interfaces/request'",
        "",
        "describe('",
      }),
      i(1),
      t({
        "', () => {",
        "  let server: IServer",
        "",
        "  beforeAll(async () => {",
        "    server = await createServer()",
        "    const prisma = server.app.prisma",
        "    server.plugins.mailer.sendEmail = jest.fn().mockResolvedValue(true)",
        "    // Reset data in DB",
        "    await clearDb(prisma)",
        "  })",
        "",
        "  afterEach(() => {",
        "    const mock = server.plugins.mailer.sendEmail as jest.Mock",
        "    mock.mockReset()",
        "  })",
        "",
        "  afterAll(async () => {",
        "    await server.stop()",
        "  })",
        "",
        "  describe('",
      }),
      i(2),
      t({
        "', () => {",
        "",
        "    test('",
      }),
      i(3),
      t({
        "', async () => {",
        "      const prisma = server.app.prisma",
        "      const response = await server.inject({",
        "        method: 'GET',",
        "        url: '/v1/",
      }),
      i(4),
      t({
        "',",
        "      })",
        "      expect(response.statusCode).toEqual(200)",
        "      ",
      }),
      i(5),
      t({
        "",
        "    })",
        "  })",
        "})",
      })
    }
  ),

  s(
    {
      trig = "ctfdesc",
      name = "ts-test-file-describe",
      description = "Adds describe() boilerplate for test files",
    }, {
      t({
        "describe('",
      }),
      i(1),
      t({
        "', () => {",
        "  "
      }),
      i(0),
      t({
        "",
        "})",
      })
    }
  ),
  s(
    {
      trig = "ctftest",
      name = "ts-test-file-test",
      description = "Adds test() boilerplate for test files",
    }, {
      t({
        "test('",
      }),
      i(1),
      t({
        "', async () => {",
        "  const prisma = server.app.prisma",
        "  const response = await server.inject({",
        "    method: 'GET',",
        "    url: '/v1/",
      }),
      i(2),
      t({
        "',",
        "  })",
        "  expect(response.statusCode).toEqual(200)",
        "  ",
      }),
      i(0),
      t({
        "",
        "})",
      })
    }
  ),

  s(
    {
      trig = "ctfuser",
      name = "ts-test-file-user",
      description = "Adds a test user",
    }, {
      t({
        "const user = await createTestUser(prisma, {",
        "  email: 'user+",
      }),
      i(1),
      t({
        "@familyalbum.com',",
        "  password: 'shhh-quiet-password',",
        "  name: 'Test User',",
        "})"
      }),
    }
  ),

  s(
    {
      trig = "ctfauthrequest",
      name = "ts-test-file-add-auth-to-request",
      description = "Add authorization to an API endpoint request",
    }, {
      t({
        "auth: {",
        "  strategy: 'session',",
        "  credentials: {",
        "    userId: user.id,",
        "  },",
        "},",
      }),
    }
  ),

  s(
    {
      trig = "ctfcontact",
      name = "ts-test-file-contact",
      description = "Adds a test contact",
    }, {
      t({
        "const contact = await prisma.contact.create({",
        "  data: {",
        "    name: 'Test Contact',",
        "    wasBirthdayFilledOnImport: false,",
        "    wasBirthdayAddedBySelf: false,",
        "    contactOwnerUserId: user.id,",
        "  }",
        "})",
      }),
    }
  ),

  s(
    {
      trig = "ctfcelebration",
      name = "ts-test-file-celebration",
      description = "Adds a test celebration",
    }, {
      t({
        "const celebration = await prisma.celebration.create({",
        "  data: {",
        "    userId: user.id,",
        "    recipientContactId: contact.id,",
        "    experienceType: 'DIGITAL_GREETING_CARD',",
        "  }",
        "})",
      }),
    }
  ),

  s(
    {
      trig = "ctffakehttpwithnock",
      name = "ts-test-file-fake-http-with-nok",
      description = "Use nock to fake HTTP requests",
    }, {
      t({
        "const faked",
      }),
      i(1, "VariableName"),
      t({
        "Request = nock(/.*/)",
        "  .",
      }),
      c(2, {t("post"), t("get"), t("patch"), t("delete"), t("head"), t("options") }),
      t({
        "('/some-url') // TODO camilo: put the real URL for the service here",
        "  .reply(200, {",
        "    putDataHere: 'put data value here',",
        "  })",
        "faked",
      }),
      rep(1),
      t({
        "Request.done() // TODO camilo: move this down after the actual call"
      }),
    }
  ),
}

return M
